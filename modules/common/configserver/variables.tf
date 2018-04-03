# Resource variables
variable name {}

variable environment {}

variable region {}

//variable iam_instance_profile {}

variable "amis" {
  type = "map"
}

variable instance_type {}
variable count {}
variable key_name {}

variable subnet_id {
  type = "list"
}

variable azs {
  type = "list"
}

# Variables used in initialisation scripts / user data
variable user_data {}

# Variable used to set explicit dependencies with other modules, when no specific output (eg an ipaddress) is required. This is not used in most cases, but rather servers as an anchor for dependency setting, until terraform supports module dependencies.
variable mod_dependencies {
  default = ""
}

variable disable_api_termination {}

variable "sg_id" {
  type = "list"
}
