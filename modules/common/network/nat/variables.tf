variable "name" {
  default = "nat"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "public_subnet_count" {
  default = 2
} #Number of public subnets = number of availability zones. We need one NAT per subnet for HA but need to declare how many loops are needed to create those NATs.

variable "nat_eip_allocation_ids" {
  type = "list"
}

variable "azs" {
  type = "list"
}

variable "environment" {}
