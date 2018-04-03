provider "aws" {
  version = "~> 1.10.0"

  // access/secret keys are sourced from env vars.
  region = "${var.region}"
}

terraform {
  required_version = "~> 0.11.3"

  backend "s3" {
    bucket = "cil-lite"
    key    = "terraform-state/cndev/terraform.tfstate"
    region = "cn-north-1"
  }
}

data "terraform_remote_state" "networking" {
  backend = "s3"

  config {
    bucket = "cil-lite"
    key    = "terraform-state/cndev/terraform.tfstate"
    region = "${var.region}"
  }
}

module "network" {
  source         = "../../modules/common/network"
  name           = "${var.name}"
  environment    = "${var.environment}"
  cidr           = "${var.cidr}"
  public_subnets = "${coalesce(var.public_subnets, format("%s,%s", cidrsubnet(var.cidr, var.subnet_newbits, 0), cidrsubnet(var.cidr, var.subnet_newbits, 1)))}"

  private_subnets = "${coalesce(var.private_subnets, format("%s,%s", cidrsubnet(var.cidr, var.subnet_newbits, 2), cidrsubnet(var.cidr, var.subnet_newbits, 3)))}"
  azs             = ["${var.azs}"]
  azs_count       = "${length(var.azs)}"

  // pass in aws eip allocations - they are pre-allocated for external firewall access.
  nat_eip_allocation_ids = "${var.nat_eip_allocation_ids}"
}

module "configserver" {
  source        = "../../modules/common/configserver"
  name          = "${var.name}"
  environment   = "${var.environment}"
  region        = "${var.region}"
  instance_type = "${var.configserver_instance_type}"
  key_name      = "${var.key_name}"
  count         = "${var.configserver_count}"
  user_data     = ""
  amis          = "${var.configserver_ami}"
  azs           = ["${var.azs}"]
  subnet_id     = "${module.network.private_subnet_ids}"
  sg_id         = ["${module.bastion.allow_bastion_id}"]

  //sg_id                   = "${data.terraform_remote_state.networking.integration_sg_id}"
  disable_api_termination = "${var.disable_api_termination}"

  //iam_instance_profile = "${aws_iam_instance_profile.consul-join.name}"
}

## Bastion **

module "bastion" {
  source = "../../modules/common/network/bastion"

  # cidr_blocks            = "${var.bastion_allowed_network}"
  name          = "${var.name}"
  environment   = "${var.environment}"
  instance_type = "${var.bastion_instance_type}"
  user          = "${var.bastion_user}"

  # keypair                = "${var.keypair}"
  key_name  = "${var.key_name}"
  region    = "${var.region}"
  count     = 1
  ami       = "${var.bastion_ami}"
  azs       = ["${var.azs}"]
  subnet_id = ["${module.network.public_subnet_ids}"]
  sg_id     = ["${module.bastion.bastion_ssh_id}"]
  vpc_id    = "${module.network.vpc_id}"

  bastion_allowed_network = ["${var.bastion_allowed_network}"]

  disable_api_termination = "${var.disable_api_termination}"
}

module "rabbit_mq_elb" {
  source        = "../../modules/common/elb"
  environment   = "${var.environment}"
  node_type     = "rabbitmq-elb"
  name          = "${var.name}"
  region        = "${var.region}"
  bucket_prefix = ""
  count         = 1
  subnet_ids    = ["${module.network.public_subnet_ids}"]

  //  security_group_ids   = ["${data.terraform_remote_state.networking.common_sg_id}"] //To be implemented
  //  backend_instance_ids = ["${module.proxy.list_instance_ids}"] //To be replaced by rabbitMQ autoscaling group ID
  backend_instance_count = 2

  proxy_ports         = ["5671", "5672", "15672", "25672"]
  logs_enabled        = false
  health_check_target = "TCP:15672"
  internal            = false

  elb_listeners = [{
    instance_port     = 5671
    instance_protocol = "tcp"
    lb_port           = 5671
    lb_protocol       = "tcp"
  },
    {
      instance_port     = 5672
      instance_protocol = "tcp"
      lb_port           = 5672
      lb_protocol       = "tcp"
    },
    {
      instance_port     = 15672
      instance_protocol = "tcp"
      lb_port           = 15672
      lb_protocol       = "tcp"
    },
    {
      instance_port     = 25672
      instance_protocol = "tcp"
      lb_port           = 25672
      lb_protocol       = "tcp"
    },
  ]

  //  mod_dependencies = "${module.proxy.private_ips}" //To be replaced by rabbitMQ autoscaling group module
}

module "mmb_alb" {
  source      = "../../modules/common/alb"
  environment = "${var.environment}"
  alb_name    = "mmb-alb"
  name        = "${var.name}"
  subnets     = ["${module.network.public_subnet_ids}"]

  //  security_group_ids   = ["${data.terraform_remote_state.networking.common_sg_id}"] //To be implemented
  //  backend_instance_ids = ["${module.proxy.list_instance_ids}"] //To be replaced by rabbitMQ autoscaling group ID
  internal = false

  vpc_id = "${module.network.vpc_id}"

  //  mod_dependencies = "${module.proxy.private_ips}" //To be replaced by rabbitMQ autoscaling group module
}

module "mmb_tg" {
  source            = "../../modules/common/alb/target-group"
  alb_name          = "mmb-alb"
  backend_port      = 443
  backend_protocol  = "HTTPS"
  vpc_id            = "${module.network.vpc_id}"
  health_check_path = "/"
}

module "mmb_ls" {
  source           = "../../modules/common/alb/listener"
  alb_arn          = "${module.mmb_alb.alb_arn}"
  alb_https_port   = 443
  alb_protocols    = ["HTTPS"]
  certificate_arn  = "${var.alb_certificate_arn}"
  target_group_arn = "${module.mmb_tg.target_group_arn}"
}

module "rds-sg" {
  source           = "../../modules/common/security_groups"
  environment      = "${var.environment}"
  name             = "${var.name}"
  vpc_id           = "${module.network.vpc_id}"
  sg_name          = "rds"
  mod_dependencies = "${module.allow_mysql.rule_desc}"
}

module "allow_mysql" {
  source = "../../modules/common/security_groups/rules/rds"
  sg_id  = "${module.rds-sg.sg_id}"
}

# module "rds" {
#   source                      = "../../modules/common/rds"
#   allocated_storage           = "${var.rds_allocated_storage}"
#   identifier                  = "${var.rds_identifier}"
#   environment                 = "${var.environment}"
#   name                        = "${var.name}"
#   storage_type                = "${var.rds_storage_type}"
#   instance_type               = "${var.rds_instance_type}"
#   db_name                     = "${var.rds_db_name}"
#   master_username             = "${var.rds_master_username}"
#   master_password             = "${var.rds_master_password}"
#   multi_az                    = "${var.rds_multi_az}"
#   backup_retention_period     = "${var.rds_backup_retention_period}"
#   security_group_ids          = ["${module.rds-sg.sg_id}"]
#   allow_major_version_upgrade = "${var.rds_allow_major_version_upgrade}"
#   apply_immediately           = "${var.rds_apply_immediately}"
#   auto_minor_version_upgrade  = "${var.rds_auto_minor_version_upgrade}"
#   backup_window               = "${var.rds_backup_window}"
#   maintenance_window          = "${var.rds_maintenance_window}"
#   subnet_ids                  = ["${module.network.private_subnet_ids}"]
# }

module "govreg" {
  source                  = "../../modules/common/governance_registry"
  name                    = "${var.name}"
  environment             = "${var.environment}"
  instance_type           = "${var.gr_instance_type}"
  key_name                = "${var.key_name}"
  region                  = "${var.region}"
  vpc_id                  = "${module.network.vpc_id}"
  count                   = 1
  user                    = "${var.user}"
  ami                     = "${var.gr_ami}"
  azs                     = ["${var.azs}"]
  subnet_id               = ["${module.network.public_subnet_ids}"]
  disable_api_termination = "${var.disable_api_termination}"
  ebs_volume_size         = "${var.gr_ebs_volume_size}"
  root_volume_size        = "${var.gr_root_volume_size}"

  # sg_id            = "${module.integration.sg_id}"
  # sds_ips          = "${module.consul.private_ips}"
  # puppet_master_ip = "${module.configserver.private_ips}"
}

module "messaging_node" {
  source                  = "../../modules/common/messaging_node"
  name                    = "${var.name}"
  environment             = "${var.environment}"
  instance_type           = "${var.messaging_instance_type}"
  key_name                = "${var.key_name}"
  region                  = "${var.region}"
  vpc_id                  = "${module.network.vpc_id}"
  count                   = 2
  user                    = "${var.user}"
  ami                     = "${var.messaging_ami}"
  azs                     = ["${var.azs}"]
  subnet_id               = ["${module.network.public_subnet_ids}"]
  disable_api_termination = "${var.disable_api_termination}"
  ebs_volume_size         = "${var.messaging_ebs_volume_size}"
  root_volume_size        = "${var.messaging_root_volume_size}"

  # sg_id            = "${module.integration.sg_id}"
  # sds_ips          = "${module.consul.private_ips}"
  # puppet_master_ip = "${module.configserver.private_ips}"
}

module "mmb_node" {
  source                  = "../../modules/common/mmb_node"
  name                    = "${var.name}"
  environment             = "${var.environment}"
  instance_type           = "${var.mmb_instance_type}"
  key_name                = "${var.key_name}"
  region                  = "${var.region}"
  vpc_id                  = "${module.network.vpc_id}"
  count                   = 2
  user                    = "${var.user}"
  ami                     = "${var.mmb_ami}"
  azs                     = ["${var.azs}"]
  subnet_id               = ["${module.network.public_subnet_ids}"]
  disable_api_termination = "${var.disable_api_termination}"
  ebs_volume_size         = "${var.mmb_ebs_volume_size}"
  root_volume_size        = "${var.mmb_root_volume_size}"

  # sg_id            = "${module.integration.sg_id}"
  # sds_ips          = "${module.consul.private_ips}"
  # puppet_master_ip = "${module.configserver.private_ips}"
}
