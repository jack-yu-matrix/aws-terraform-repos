variable "cidr" {}
variable "name" {}
variable "environment" {}
variable "region" {}

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
