variable "vpc_id" {}

variable "environment" {}

variable "name" {}

variable "sg_name" {
  description = "A base name for the security group. Needs to be unique each time if this module is used more than once within the same environment, eg. allow-consul-lan and allow-consul-wan"
}

variable "mod_dependencies" {}
