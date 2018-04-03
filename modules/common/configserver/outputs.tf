output "public_ips" {
  value = "${join(",", aws_instance.configserver-server.*.public_ip)}"
}

output "private_ips" {
  value = "${join(",", aws_instance.configserver-server.*.private_ip)}"
}
