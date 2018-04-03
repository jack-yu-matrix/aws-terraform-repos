module "vpc" {
  source      = "./vpc"
  name        = "${var.name}"
  environment = "${var.environment}"
  cidr        = "${var.cidr}"
}

#import public_subnet module and pass params
module "public_subnet" {
  source      = "./public_subnet"
  name        = "${var.name}-public-subnet"
  environment = "${var.environment}"

  # get vpc id from the vpc module output
  vpc_id = "${module.vpc.vpc_id}"

  # get public subnets (sourced from <environment>.tfvars)
  cidrs = "${var.public_subnets}"

  # get azs (sourced from <environment>.tfvars)
  azs = ["${var.azs}"]
}

#import private_subnet module and pass params
module "private_subnet" {
  source      = "./private_subnet"
  name        = "${var.name}-private-subnet"
  environment = "${var.environment}"

  # get vpc id from the vpc module output
  vpc_id = "${module.vpc.vpc_id}"

  # get private subnets (sourced from <environment>.tfvars)
  cidrs = "${var.private_subnets}"

  # get azs (sourced from <environment>.tfvars)
  azs = "${var.azs}"

  nat_gateway_ids = "${module.nat.gateway_ids}"

  //peering_connection_id = "${module.peering.peering_connection_id}"
  //peered_network_cidr   = "${var.peer_from_vpc_cidr}"
}

module "nat" {
  source = "./nat"

  # set name of the nat (sourced from <environment>.tfvars)
  name        = "${var.name}-nat"
  environment = "${var.environment}"

  # get list of public subnet ids
  public_subnet_ids   = ["${module.public_subnet.subnet_ids}"]
  public_subnet_count = "${var.azs_count}"

  nat_eip_allocation_ids = "${var.nat_eip_allocation_ids}"

  # get azs (sourced from <environment>.tfvars)
  azs = "${var.azs}"
}
