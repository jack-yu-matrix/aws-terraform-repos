resource "aws_elb" "elastic-load-balancer" {
  count   = "${var.count}"
  name    = "${var.name}-${var.environment}-${var.node_type}-${count.index}"
  subnets = ["${var.subnet_ids}"]

  //  security_groups = ["${var.security_group_ids}"]
  internal = "${var.internal}"

  //   access_logs {
  //     bucket        = "${var.bucket_prefix}-terraform-${var.region}"
  //     bucket_prefix = "${var.client_prefix}/environments/${var.environment}/base/${var.node_type}-${count.index}"
  //     interval      = 5
  //     enabled       = "${var.logs_enabled}"
  //   }

  # listener {
  #   instance_port     = "${var.instance_port}"
  #   instance_protocol = "tcp"
  #   lb_port           = "${var.lb_port}"
  #   lb_protocol       = "tcp"
  # }
  listener = ["${var.elb_listeners}"]
  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${var.health_check_target}"
    interval            = 6
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300
  tags {
    Name        = "${var.name}-${var.environment}-${var.node_type}-${count.index}"
    Environment = "${var.environment}"
    Client      = "${var.name}"
  }
}

# resource "aws_elb_attachment" "elb-attachment" {
#   count    = "${var.backend_instance_count}"
#   elb      = "${aws_elb.elastic-load-balancer.id}"
#   instance = "${element(var.backend_instance_ids, count.index)}"
# }

resource "aws_proxy_protocol_policy" "nginx" {
  count          = "${var.count}"
  load_balancer  = "${element(aws_elb.elastic-load-balancer.*.name, count.index)}"
  instance_ports = ["${var.proxy_ports}"]
}
