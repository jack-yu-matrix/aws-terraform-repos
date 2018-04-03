## Capgemini China PLC Proprietary and Confidential ##
## Copyright Capgemini 2018 - All Rights Reserved ##

# This module creates elastic IP addresses and NAT gateways for specified public subnet(s)

resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(var.nat_eip_allocation_ids, count.index)}"
  subnet_id     = "${element(var.public_subnet_ids, count.index)}"      #Get list of subnet ids by , delimiter
  count         = "${var.public_subnet_count}"                          #This is the number of AZS available. This must match AZS in

  tags {
    Name        = "${var.name}-${var.azs[count.index]}"
    Type        = "nat-gateway"
    Environment = "${var.environment}"
  }
}
