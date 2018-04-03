resource "aws_security_group_rule" "bastion_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.allowed_ips}"]
  security_group_id = "${var.sg_id}"
  description       = "Managed by Terraform"
}
