######### OUTPUTS ####################

output "subnet_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "subnet_cidrs" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

output "private_route_table_ids" {
  value = ["${aws_route_table.private.*.id}"]
}
