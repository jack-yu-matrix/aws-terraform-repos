output "vpc_id" {
  value = "${aws_vpc.cil_lite.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.cil_lite.cidr_block}"
}
