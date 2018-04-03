output "subnet_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "subnet_cidrs" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "route_table_id" {
  value = "${aws_route_table.public.id}"
}

output "ig_id" {
  value = "${aws_internet_gateway.public.id}"
}
