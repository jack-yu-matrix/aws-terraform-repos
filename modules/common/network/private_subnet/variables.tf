variable "name" {
  default = "private"
}

variable "environment" {}
variable "vpc_id" {} #obtained via output from ../network/vpc/main.tf
variable "cidrs" {}

variable "azs" {
  type = "list"
}

variable "nat_gateway_ids" {
  type = "list"
}

#obtained from network module

