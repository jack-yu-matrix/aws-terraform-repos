# config server ec2 instance for puppet installation
resource "aws_instance" "configserver-server" {
  ami                     = "${lookup(var.amis, var.region)}"
  instance_type           = "${var.instance_type}"
  availability_zone       = "${element(var.azs, count.index)}"
  disable_api_termination = "${var.disable_api_termination}"
  key_name                = "${var.key_name}"
  tenancy                 = "default"
  subnet_id               = "${element(var.subnet_id, count.index)}"

  vpc_security_group_ids = ["${var.sg_id}"]

  //iam_instance_profile    = "${var.iam_instance_profile}"
  //vpc_security_group_ids = ["${var.sg_id}"]

  tags {
    Name         = "${var.name}-configserver-${count.index}"
    Environment  = "${var.environment}"
    Dependencies = "${var.mod_dependencies}"
  }
  volume_tags {
    Name = "${var.name}-configserver-${count.index}"
  }
  root_block_device {
    delete_on_termination = true
  }
  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }
}
