variable "cidr" {}
variable "name" {}
variable "environment" {}
variable "public_subnets" {}
variable "private_subnets" {}

variable "nat_eip_allocation_ids" {
  type = "list"
}

variable "azs" {
  type = "list"
}

variable "azs_count" {
  default = 2
}
