resource "aws_security_group_rule" "allow_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.bastion_cidr}"]
  security_group_id = "${var.sg_id}"
  description       = "Managed by Terraform"
}
