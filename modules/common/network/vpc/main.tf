# Create a VPC to launch our instances into
resource "aws_vpc" "cil_lite" {
  cidr_block       = "${var.cidr}"
  instance_tenancy = "${var.instance_tenancy}"

  tags {
    Name = "${var.name}-${var.environment}"
  }
}
