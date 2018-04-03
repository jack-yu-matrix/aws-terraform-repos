output "public_ips" {
  value = "${join(",", aws_instance.governance-registry-server.*.public_ip)}"
}

output "private_ips" {
  value = "${join(",", aws_instance.governance-registry-server.*.private_ip)}"
}
