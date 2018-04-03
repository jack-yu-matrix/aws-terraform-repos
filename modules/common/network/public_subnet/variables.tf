variable "name" {
  default = "public"
}

variable "environment" {}
variable "vpc_id" {}
variable "cidrs" {}

variable "azs" {
  type = "list"
}
