resource "aws_security_group_rule" "mysql_rds_sg" {
  type      = "ingress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"
  self      = true

  security_group_id = "${var.sg_id}"
}

resource "aws_security_group_rule" "mysql_rds_sg_out" {
  type      = "egress"
  from_port = 3306
  to_port   = 3306
  protocol  = "tcp"
  self      = true

  security_group_id = "${var.sg_id}"
}
