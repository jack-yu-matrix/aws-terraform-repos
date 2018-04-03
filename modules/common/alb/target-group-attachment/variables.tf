variable "target_id" {
  description = "The ID of the instance to attach target group"
  default     = {}
}

variable "target_group_arn" {
  description = "ARN of target group to add attachment"
  default     = {}
}

variable "target_group_id" {}
