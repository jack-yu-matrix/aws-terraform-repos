variable environment {}

variable instance_type {}

variable db_name {}

variable identifier {}

variable allocated_storage {
  default = "100"
}

variable allow_major_version_upgrade {
  default = "false"
}

variable apply_immediately {
  default = "false"
}

variable auto_minor_version_upgrade {
  default = "false"
}

variable backup_window {
  default = "16:00-17:00"
}

variable maintenance_window {
  default = "Mon:00:00-Mon:03:00"
}

variable storage_type {
  default = "gp2"
}

variable subnet_ids {
  type = "list"
}

variable master_username {}

variable master_password {}

variable db_engine {
  default = "mysql"
}

variable db_engine_version {
  default = "5.6.37"
}

variable backup_retention_period {
  default = "7"
}

variable parameter_group_name {
  default = "default.mysql5.6"
}

variable multi_az {
  default = true
}

variable port {
  default = "3306"
}

variable publicly_accessible {
  default = false
}

variable client {
  default = "core"
}

variable name {
  default = ""
}

# Variable used to set explicit dependencies with other modules, when no specific output (eg an ipaddress) is required. This is not used in most cases, but rather servers as an anchor for dependency setting, until terraform supports module dependencies.
variable mod_dependencies {
  default = ""
}

variable security_group_ids {
  default = []
}
