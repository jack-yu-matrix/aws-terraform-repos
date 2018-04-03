output "dns_names" {
  value = ["${aws_elb.elastic-load-balancer.*.dns_name}"]
}

output "zone_ids" {
  value = ["${aws_elb.elastic-load-balancer.*.zone_id}"]
}
