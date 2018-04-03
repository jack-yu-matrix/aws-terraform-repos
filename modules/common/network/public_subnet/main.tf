## Capgemini China PLC Proprietary and Confidential ##
## Copyright Capgemini 2018 - All Rights Reserved ##

resource "aws_subnet" "public" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${element(split(",", var.cidrs), count.index)}" #delimit array by comma delimter
  availability_zone = "${var.azs[count.index]}"                        #delimit array by comma delimter
  count             = "${length(split(",", var.cidrs))}"               #get count (number of cidrs) from array of cidrs

  tags {
    Name        = "${var.name}-${var.azs[count.index]}"
    Type        = "public"
    Environment = "${var.environment}"
  }

  map_public_ip_on_launch = true

  depends_on = ["aws_internet_gateway.public"]
}

resource "aws_internet_gateway" "public" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${var.vpc_id}"

  # count  = "${length(split(",", var.cidrs))}"

  tags {
    # Name = "${var.name}.${element(split(",",var.azs), count.index)}"
    Name        = "${var.name}"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "internet-to-gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.public.id}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(split(",", var.cidrs))}"
  subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"

  # route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}
