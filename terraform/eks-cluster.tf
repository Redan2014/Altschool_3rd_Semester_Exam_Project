provider "kubernetes" {
  # load_config_file       = "false"
  host                   = data.aws_eks_cluster.mongoapp-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.mongoapp-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.mongoapp-cluster.certificate_authority.0.data)
}
  
data "aws_eks_cluster" "mongoapp-cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "mongoapp-cluster" {
  name = module.eks.cluster_id
}

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
        max_size = 3
        asg_desired_capacity = 2
    }
  ]
}