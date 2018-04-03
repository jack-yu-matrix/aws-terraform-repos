resource "aws_security_group" "sg" {
  name   = "${var.name}-${var.sg_name}-${var.environment}"
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "${var.name}-${var.sg_name}-${var.environment}"
    Environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
