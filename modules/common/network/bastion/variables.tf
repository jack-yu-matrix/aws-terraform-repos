# Resource variables

variable "cidrs" {
  default = ""
}

variable "public_cidrs" {
  default = ""
}

# variable "allowed_networks 	{
# 	type = "list"

# 	description = "A list of CIDR Networks to allow ssh access to."
#  }

variable "vpc_id" {}

variable "count" {}

variable "environment" {}

variable "key_name" {}

variable "azs" {
  type = "list"
}

variable "instance_type" {}

variable "ami" {
  type = "map"
}

variable "subnet_id" {
  type = "list"
}

variable "user" {}

variable "region" {}

variable "sg_id" {
  type = "list"
}

variable "name" {}

variable "disable_api_termination" {}

variable "bastion_allowed_network" {
  type = "list"
}
