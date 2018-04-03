resource "aws_instance" "messaging-node" {
  ami                     = "${lookup(var.ami, var.region)}"
  instance_type           = "${var.instance_type}"
  count                   = "${var.count}"
  key_name                = "${var.key_name}"
  subnet_id               = "${element(var.subnet_id, count.index)}"
  disable_api_termination = "${var.disable_api_termination}"
  availability_zone       = "${element(var.azs, count.index)}"

  #   vpc_security_group_ids  = ["${var.sg_id}"]

  tags {
    Name               = "${var.name}-${var.environment}-messaging-node-${count.index}"
    Environment        = "${var.environment}"
    Client             = "${var.name}"
    Dependencies       = "${var.mod_dependencies}"
    Consul_Environment = "${var.environment}"
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = "${var.root_volume_size}"
  }
  ebs_block_device {
    device_name = "dev/sdf"
    volume_size = "${var.ebs_volume_size}"
    volume_type = "gp2"
  }
  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }
}
