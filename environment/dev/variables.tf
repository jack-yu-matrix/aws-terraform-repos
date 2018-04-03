variable "cidr" {}
variable "name" {}
variable "environment" {}
variable "region" {}
variable user {}

variable "azs" {
  type = "list"
}

variable "public_subnets" {
  default = ""
}

variable "private_subnets" {
  default = ""
}

variable "subnet_newbits" {
  default = ""
}

variable "azs_count" {
  default = 2
}

variable "nat_eip_allocation_ids" {
  type = "list"
}

variable configserver_ami {
  type = "map"
}

variable configserver_instance_type {}

variable configserver_count {
  default = "1"
}

variable key_name {}

variable disable_api_termination {}

variable bastion_instance_type {}

variable bastion_ami {
  type = "map"
}

variable bastion_allowed_network {
  type = "list"
}

variable bastion_user {}

variable alb_certificate_arn {}

variable "rds_allocated_storage" {}
variable "rds_storage_type" {}
variable "rds_instance_type" {}
variable "rds_db_name" {}
variable "rds_master_username" {}
variable "rds_master_password" {}
variable "rds_multi_az" {}
variable "rds_backup_retention_period" {}
variable "rds_allow_major_version_upgrade" {}
variable "rds_apply_immediately" {}
variable "rds_auto_minor_version_upgrade" {}
variable "rds_backup_window" {}
variable "rds_maintenance_window" {}
variable "rds_identifier" {}

variable gr_ami {
  type = "map"
}

variable gr_instance_type {}
variable gr_root_volume_size {}
variable gr_ebs_volume_size {}

variable messaging_ami {
  type = "map"
}

variable messaging_instance_type {}
variable messaging_root_volume_size {}
variable messaging_ebs_volume_size {}

variable mmb_ami {
  type = "map"
}

variable mmb_instance_type {}
variable mmb_root_volume_size {}
variable mmb_ebs_volume_size {}
