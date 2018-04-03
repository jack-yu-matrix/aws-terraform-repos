## variables for networking
cidr = "10.20.0.0/16"

region = "cn-north-1"

environment = "cndev"

name = "cil-lite"

azs = ["cn-north-1a", "cn-north-1b"]

subnet_newbits = "8"

nat_eip_allocation_ids = ["eipalloc-29e1cd13", "eipalloc-2ce1cd16"]

## variables for aws instance
key_name = "cil-lite-cndev"

user = "ec2-user"

disable_api_termination = true

## variables for configserver
configserver_instance_type = "t2.2xlarge"

configserver_ami = {
  "cn-north-1" = "ami-52d1183f"
}

## variables for bastion
bastion_instance_type = "t2.micro"

bastion_ami = {
  "cn-north-1" = "ami-cb19c4a6"
}

bastion_allowed_network = [
  "180.169.57.42/32", //CG Shanghai
  "112.81.47.25/32",  //CG Kunshan
]

bastion_user = "ec2-user"

## variables for alb
alb_certificate_arn = "arn:aws-cn:iam::659181885370:server-certificate/proxy"

## variables for rds
rds_allocated_storage = "100"

rds_storage_type = "gp2"

rds_instance_type = "db.m4.xlarge"

rds_db_name = "cilbizcndev"

rds_master_username = "cilbizprod"

rds_master_password = "h26FGkMcUBemMTv"

rds_multi_az = true

rds_backup_retention_period = "7"

rds_allow_major_version_upgrade = false

rds_apply_immediately = true

rds_auto_minor_version_upgrade = false

rds_backup_window = "18:00-19:00"

rds_maintenance_window = "Sat:20:00-Sat:21:00"

rds_identifier = "cil-lite-cndev-rds"

## variables for governance registry
gr_ami = {
  "cn-north-1" = "ami-52d1183f"
}

gr_instance_type = "m3.medium"

gr_root_volume_size = 50

gr_ebs_volume_size = "300"

## variables for messaging node
messaging_ami = {
  "cn-north-1" = "ami-52d1183f"
}

messaging_instance_type = "m3.medium"

messaging_root_volume_size = 50

messaging_ebs_volume_size = "300"

## variables for mmb node
mmb_ami = {
  "cn-north-1" = "ami-52d1183f"
}

mmb_instance_type = "m3.medium"

mmb_root_volume_size = 50

mmb_ebs_volume_size = "300"
