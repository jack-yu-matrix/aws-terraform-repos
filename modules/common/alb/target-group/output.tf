output "target_group_arn" {
  description = "ARN of the target group. Useful for passing to your Auto Scaling group module."
  value       = "${aws_alb_target_group.target_group.arn}"
}

output "target_group_name" {
  description = "Name of the target group. Useful for passing to your CodeDeploy Deployment Group."
  value       = "${aws_alb_target_group.target_group.name}"
}

output "target_group_id" {
  description = "Name of the target group. Useful for passing to your CodeDeploy Deployment Group."
  value       = "${aws_alb_target_group.target_group.id}"
}
