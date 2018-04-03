variable "alb_http_port" {
  description = "The port the Load Balancer listen when HTTP is used"
  default     = 80
}

variable "alb_https_port" {
  description = "The port the Load Balancer listen when HTTPS is used"
  default     = 443
}

variable "certificate_arn" {
  description = "The ARN of the SSL Certificate. e.g. \"arn:aws:iam::123456789012:server-certificate/ProdServerCert\""
}

variable "alb_arn" {}

variable "security_policy" {
  description = "The security policy if using HTTPS externally on the ALB. See: https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html"
  default     = "ELBSecurityPolicy-2016-08"
}

variable "alb_protocols" {
  description = "The protocols the ALB accepts. e.g.: [\"HTTP\"]"
  type        = "list"
  default     = ["HTTP"]
}

variable "target_group_arn" {}
