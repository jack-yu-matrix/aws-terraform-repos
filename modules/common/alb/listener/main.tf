resource "aws_alb_listener" "frontend_http" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "${var.alb_http_port}"
  protocol          = "HTTP"
  count             = "${contains(var.alb_protocols, "HTTP") ? 1 : 0}"

  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "frontend_https" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "${var.alb_https_port}"
  protocol          = "HTTPS"
  certificate_arn   = "${var.certificate_arn}"
  ssl_policy        = "${var.security_policy}"
  count             = "${contains(var.alb_protocols, "HTTPS") ? 1 : 0}"

  default_action {
    target_group_arn = "${var.target_group_arn}"
    type             = "forward"
  }
}
