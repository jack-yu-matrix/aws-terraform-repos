output "alb_arn" {
  description = "ARN of the ALB itself. Useful for debug output, for example when attaching a WAF."
  value       = "${aws_alb.alb.arn}"
}

output "alb_dns_name" {
  description = "The DNS name of the ALB presumably to be used with a friendlier CNAME."
  value       = "${aws_alb.alb.*.dns_name}"
}

output "alb_id" {
  description = "The ID of the ALB we created."
  value       = "${aws_alb.alb.*.id}"
}

output "alb_zone_id" {
  description = "The zone_id of the ALB to assist with creating DNS records."
  value       = "${aws_alb.alb.*.zone_id}"
}
