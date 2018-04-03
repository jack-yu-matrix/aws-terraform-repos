#Bastion resources - to utilize add security group below to other nodes in VPC

resource "aws_instance" "bastion" {
  count                   = "${var.count}"
  key_name                = "${var.key_name}"
  subnet_id               = "${element(var.subnet_id, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  disable_api_termination = "${var.disable_api_termination}"
  ami                     = "${lookup(var.ami, var.region)}"
  instance_type           = "${var.instance_type}"
  key_name                = "${var.key_name}"

  vpc_security_group_ids = ["${var.sg_id}"]

  #subnet_id = "${aws_subnet.dmz.id}"
  #subnet_id = "${var.cidrs}"
  associate_public_ip_address = true

  source_dest_check = false

  #user_data = "${file(\"files/bastion/cloud-init.txt\")}"
  connection {
    user     = "${var.user}"
    key_file = "${var.keypair}"
  }

  tags {
    Name        = "${var.name}-bastion-${count.index}"
    Subnet      = "${element(var.subnet_id, count.index)}"
    Role        = "bastion"
    Environment = "${var.environment}"
  }

  root_block_device {
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }
}

module "bastion_ssh" {
  source           = "../../security_groups"
  sg_name          = "bastion_ssh"
  environment      = "${var.environment}"
  vpc_id           = "${var.vpc_id}"
  name             = "${var.name}"
  mod_dependencies = "${format("%s,%s", module.bastion_ssh_rules.rule_desc, module.bastion_ssh_egress.rule_desc)}"
}

module "bastion_ssh_rules" {
  source      = "../../security_groups/rules/bastion_ssh"
  sg_id       = "${module.bastion_ssh.sg_id}"
  allowed_ips = ["${var.bastion_allowed_network}"]
}

module "bastion_ssh_egress" {
  source      = "../../security_groups/rules/egress"
  source_cidr = ["0.0.0.0/0"]
  sg_id       = "${module.bastion_ssh.sg_id}"
}

module "allow_bastion" {
  source           = "../../security_groups"
  sg_name          = "allow_bastion"
  environment      = "${var.environment}"
  vpc_id           = "${var.vpc_id}"
  name             = "${var.name}"
  mod_dependencies = "${format("%s,%s", module.allow_bastion_rules.rule_desc, module.allow_bastion_egress.rule_desc)}"
}

module "allow_bastion_rules" {
  source       = "../../security_groups/rules/allow_bastion"
  sg_id        = "${module.allow_bastion.sg_id}"
  bastion_cidr = ["${join(",", aws_instance.bastion.*.private_ip)}/32"]
}

module "allow_bastion_egress" {
  source      = "../../security_groups/rules/egress"
  source_cidr = ["0.0.0.0/0"]
  sg_id       = "${module.allow_bastion.sg_id}"
}
