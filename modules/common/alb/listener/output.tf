output "alb_listener_https_id" {
  description = "The ID of the ALB Listener we created."
  value       = "${element(concat(aws_alb_listener.frontend_https.*.id, list("")), 0)}"
}

output "alb_listener_http_id" {
  description = "The ID of the ALB Listener we created."
  value       = "${element(concat(aws_alb_listener.frontend_http.*.id, list("")), 0)}"
}
