variable "sg_id" {
  description = "The id of the security group to apply the following rules to"
  default     = ""
}

variable "source_cidr" {
  description = "The source CIDR block(s) to allow traffic to"
  default     = ["0.0.0.0/0"]
}

variable "rule_desc" {
  default = "egress_rules"
}
