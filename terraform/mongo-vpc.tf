
data "aws_availability_zones" "azs" {}

module "mongoapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "mongoapp-vpc"
  cidr = var.vpc_cidr
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  azs = data.aws_availability_zones.azs.names

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/mongoapp-eks-cluster" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/mongoapp-eks-cluster" = "shared"
    "kubernetes.io/role/elb" = 1
  }
    private_subnet_tags = {
        "kubernetes.io/cluster/mongoapp-eks-cluster" = "shared"
        "kubernetes.io/role/internal-elb" = 1
    }
}