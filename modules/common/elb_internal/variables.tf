variable "environment" {
  default = ""
}

variable "count" {
  default = "1"
}

variable "subnet_ids" {
  type = "list"
}

variable "proxy_ports" {
  type = "list"
}

variable "client_prefix" {
  default = ""
}

variable "health_check_target" {
  default = "TCP:80"
}

variable "region" {}
variable "bucket_prefix" {}

variable "logs_enabled" {
  default = false
}

variable "backend_instance_ids" {
  default = []
}

variable "backend_instance_count" {}

variable "node_type" {
  default = "elastic-load-balancer"
}

variable "security_group_ids" {
  default = []
}

variable "mod_dependencies" {
  default = ""
}
