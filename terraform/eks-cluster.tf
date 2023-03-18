module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.10.0"

  cluster_name = "mongoapp-eks-cluster"
  cluster_version = "1.24"

  subnet_ids = module.mongoapp-vpc.private_subnets
  vpc_id = module.mongoapp-vpc.vpc_id

  tags = {
    environment = "development"
    application = "mongoapp"
  }

  self_managed_node_group_defaults =  [
    {
        instance_type = "t3.medium"
        min_size = 1
        max_size = 4
        asg_desired_capacity = 3
    }
  ]
}
