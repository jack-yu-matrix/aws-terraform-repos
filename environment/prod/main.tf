provider "aws" {
  version = "~> 1.10.0"

  // access/secret keys are sourced from env vars.
  region = "${var.region}"
}

terraform {
  required_version = "~> 0.11.3"

  backend "s3" {
    bucket = "cil-lite"
    key    = "terraform-state/prod/terraform.tfstate"
    region = "cn-north-1"
  }
}

module "network" {
  source         = "../../modules/common/network"
  name           = "${var.name}"
  environment    = "${var.environment}"
  cidr           = "${var.cidr}"
  public_subnets = "${coalesce(var.public_subnets, format("%s,%s", cidrsubnet(var.cidr, var.subnet_newbits, 0), cidrsubnet(var.cidr, var.subnet_newbits, 1)))}"

  private_subnets = "${coalesce(var.private_subnets, format("%s,%s", cidrsubnet(var.cidr, var.subnet_newbits, 2), cidrsubnet(var.cidr, var.subnet_newbits, 3)))}"
  azs             = ["${var.azs}"]
  azs_count       = "${length(var.azs)}"

  // pass in aws eip allocations - they are pre-allocated for external firewall access.
  nat_eip_allocation_ids = "${var.nat_eip_allocation_ids}"
}
