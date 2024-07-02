locals {
  vpc_name = "${var.name_prefix}-vpc"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.vpc_name
  cidr = "10.11.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.11.1.0/24", "10.11.2.0/24", "10.11.3.0/24"]
  public_subnets  = ["10.11.101.0/24", "10.11.102.0/24", "10.11.103.0/24"]

  enable_nat_gateway = true
}