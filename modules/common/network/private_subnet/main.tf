## Capgemini China PLC Proprietary and Confidential ##
## Copyright Capgemini 2018 - All Rights Reserved ##

resource "aws_subnet" "private" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.cidrs), count.index)}" #delimit array by comma delimter
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(split(",", var.cidrs))}"               #get count (number of cidrs) from array of cidrs

  tags {
    Name        = "${var.name}-${var.azs[count.index]}"
    Type        = "private"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${var.vpc_id}"
  count  = "${length(split(",", var.cidrs))}"

  tags {
    Name        = "${var.name}.${var.azs[count.index]}"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "outbound-to-gateway" {
  count                  = "${length(split(",", var.cidrs))}"
  route_table_id         = "${element(aws_route_table.private.*.id,count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(var.nat_gateway_ids, count.index)}"
}

//resource "aws_route" "to-peering" {
// count                     = "${length(split(",", var.cidrs))}"
//route_table_id            = "${element(aws_route_table.private.*.id,count.index)}"
//destination_cidr_block    = "${var.peered_network_cidr}"
//vpc_peering_connection_id = "${var.peering_connection_id}"
//}

resource "aws_route_table_association" "private" {
  count          = "${length(split(",", var.cidrs))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
