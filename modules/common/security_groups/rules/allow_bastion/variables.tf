variable "sg_id" {
  description = "The id of the security group to apply the following rules to"
}

variable "rule_desc" {
  default = "allow_bastion"
}

variable "bastion_cidr" {
  description = "Private CIDR of Bastion server"
  type        = "list"
}
