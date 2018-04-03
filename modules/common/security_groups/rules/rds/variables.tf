variable "sg_id" {
  description = "The id of the security group to apply the following rules to"
  default     = ""
}

variable "source_sg_id" {
  description = "The security group id where requests should be accepted from"
  default     = ""
}

variable "rule_desc" {
  default = "MySQL traffic"
}
