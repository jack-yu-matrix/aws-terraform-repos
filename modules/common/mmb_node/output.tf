output "public_ips" {
  value = "${join(",", aws_instance.mmb-node.*.public_ip)}"
}

output "private_ips" {
  value = "${join(",", aws_instance.mmb-node.*.private_ip)}"
}
