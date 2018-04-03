resource "aws_alb" "alb" {
  name    = "${var.name}-${var.environment}-${var.alb_name}"
  subnets = ["${var.subnets}"]

  //  security_groups = ["${var.security_group_ids}"]
  internal = "${var.internal}"

  tags {
    Name        = "${var.name}-${var.environment}-${var.alb_name}"
    Environment = "${var.environment}"
    Client      = "${var.name}"
  }
}
