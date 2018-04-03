resource "aws_db_instance" "rds" {
  identifier                  = "${var.identifier}"
  allocated_storage           = "${var.allocated_storage}"
  storage_type                = "${var.storage_type}"
  engine                      = "${var.db_engine}"
  engine_version              = "${var.db_engine_version}"
  instance_class              = "${var.instance_type}"
  name                        = "${var.db_name}"
  username                    = "${var.master_username}"
  password                    = "${var.master_password}"
  db_subnet_group_name        = "${aws_db_subnet_group.rds-subnets.id}"
  multi_az                    = "${var.multi_az}"
  backup_retention_period     = "${var.backup_retention_period}"
  vpc_security_group_ids      = ["${var.security_group_ids}"]
  allow_major_version_upgrade = "${var.allow_major_version_upgrade}"
  apply_immediately           = "${var.apply_immediately}"
  auto_minor_version_upgrade  = "${var.auto_minor_version_upgrade}"
  backup_window               = "${var.backup_window}"
  maintenance_window          = "${var.maintenance_window}"
  copy_tags_to_snapshot       = "false"
  parameter_group_name        = "${var.parameter_group_name}"
  port                        = "${var.port}"
  publicly_accessible         = "${var.publicly_accessible}"
  monitoring_interval         = 0

  tags {
    Name         = "rds-instance"
    Environment  = "${var.environment}"
    Client       = "${var.name}"
    Dependencies = "${var.mod_dependencies}"
  }
}

resource "aws_db_subnet_group" "rds-subnets" {
  name       = "${var.environment}-dp-rds-subnet-group"
  subnet_ids = ["${var.subnet_ids}"]

  tags {
    Name         = "${var.environment}-dp-rds-subnet-group"
    Environment  = "${var.environment}"
    Client       = "${var.name}"
    Dependencies = "${var.mod_dependencies}"
  }
}
