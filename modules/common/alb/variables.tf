variable "internal" {
  description = "Boolean determining if the ALB is internal or externally facing."
  default     = false
}

variable "name" {}
variable "environment" {}

variable "alb_name" {
  description = "The name of the ALB as will show in the AWS EC2 ELB console."
}

# variable "alb_security_groups" {
#   description = "The security groups with which we associate the ALB. e.g. [\"sg-edcd9784\",\"sg-edcd9785\"]"
#   type        = "list"
# }

variable "enable_logging" {
  default     = false
  description = "Enable the ALB to write log entries to S3."
}

variable "log_bucket_name" {
  description = "S3 bucket for storing ALB access logs. To create the bucket \"create_log_bucket\" should be set to true."
  default     = ""
}

variable "log_location_prefix" {
  description = "S3 prefix within the log_bucket_name under which logs are stored."
  default     = ""
}

variable "subnets" {
  description = "A list of subnets to associate with the ALB. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = "list"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "vpc_id" {
  description = "VPC id where the ALB and other resources will be deployed."
}
