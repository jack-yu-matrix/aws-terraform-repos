variable "backend_protocol" {
  description = "The protocol the backend service speaks. Options: HTTP, HTTPS, TCP, SSL (secure tcp)."
  default     = "HTTP"
}

variable "cookie_duration" {
  description = "If load balancer connection stickiness is desired, set this to the duration in seconds that cookie should be valid (e.g. 300). Otherwise, if no stickiness is desired, leave the default."
  default     = 1
}

variable "deregistration_delay" {
  description = "The amount time to wait before changing the state of a deregistering target from draining to unused."
  default     = 300
}

variable "health_check_healthy_threshold" {
  description = "Number of consecutive positive health checks before a backend instance is considered healthy."
  default     = 3
}

variable "health_check_interval" {
  description = "Interval in seconds on which the health check against backend hosts is tried."
  default     = 10
}

variable "health_check_path" {
  description = "The URL the ELB should use for health checks. e.g. /health"
}

variable "health_check_port" {
  description = "The port used by the health check if different from the traffic-port."
  default     = "traffic-port"
}

variable "health_check_timeout" {
  description = "Seconds to leave a health check waiting before terminating it and calling the check unhealthy."
  default     = 5
}

variable "health_check_unhealthy_threshold" {
  description = "Number of consecutive positive health checks before a backend instance is considered unhealthy."
  default     = 3
}

variable "health_check_matcher" {
  description = "The HTTP codes that are a success when checking TG health."
  default     = "200-299"
}

variable "target_type" {
  description = "The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address). "
  default     = "instance"
}

variable "backend_port" {
  description = "The port the service on the EC2 instances listen on."
  default     = 80
}

variable "vpc_id" {}

variable "alb_name" {}
