module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.4"

  name = var.environment
  cidr = var.cidr

  azs              = var.default_availability_zones
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  database_subnets = var.database_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  create_igw         = true
  enable_nat_gateway = true

  map_public_ip_on_launch = true

  create_database_subnet_route_table = true

  # Additional tags
  public_subnet_tags = {
    Type = "public"
  }

  private_subnet_tags = {
    Type = "private"
  }

  database_subnet_tags = {
    Type = "database"
  }
}
