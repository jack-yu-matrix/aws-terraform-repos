# Resource variables
variable environment {
  default = ""
}

variable region {}

variable ami {
  type = "map"
}

variable instance_type {}
variable count {}
variable key_name {}

variable subnet_id {
  type = "list"
}

variable user {}

variable azs {
  type = "list"
}

variable vpc_id {}

variable client {
  default = "core"
}

variable name {}

# Variable used to set explicit dependencies with other modules, when no specific output (eg an ipaddress) is required. This is not used in most cases, but rather servers as an anchor for dependency setting, until terraform supports module dependencies.
variable mod_dependencies {
  default = ""
}

variable disable_api_termination {}

# variable sg_id {
#   type = "list"
# }

variable root_volume_size {}

variable ebs_volume_size {}
