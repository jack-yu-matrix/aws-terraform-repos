variable "sg_id" {
  description = "The id of the security group to apply the following rules to"
}

variable "rule_desc" {
  default = "bastion_ssh"
}

variable "allowed_ips" {
  description = "IP ranges to allow incoming SSH traffic"
  type        = "list"
}
