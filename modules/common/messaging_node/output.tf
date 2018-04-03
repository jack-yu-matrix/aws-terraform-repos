output "public_ips" {
  value = "${join(",", aws_instance.messaging-node.*.public_ip)}"
}

output "private_ips" {
  value = "${join(",", aws_instance.messaging-node.*.private_ip)}"
}
