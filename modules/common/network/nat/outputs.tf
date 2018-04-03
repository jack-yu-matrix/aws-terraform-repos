output "gateway_ids" {
  value = ["${aws_nat_gateway.nat.*.id}"]
} #join all aws nat gateways into one variable, values seperated via ",""*/
