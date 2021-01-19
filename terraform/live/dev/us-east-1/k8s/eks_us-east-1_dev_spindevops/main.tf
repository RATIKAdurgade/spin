
provider "aws" {
  region  = "us-east-1"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks_dev_us-east-1_spindevops.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_dev_us-east-1_spindevops.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

# module "eks_dev_us-east-1_spin" {
#   source          = "terraform-aws-modules/eks/aws"
#   cluster_name    = "eks_dev_us-east-1_spin"
#   cluster_version = "1.17"
#   subnets         = ["subnet-0e38769ceb1c5e312", "subnet-0aaa0d9a5c8a423d2"]
#   vpc_id          = "vpc-0fe31fe2fcee00768"
#   cluster_endpoint_public_access = true
#   cluster_endpoint_public_access_cidrs = ["67.164.73.109/32"]
 
#   worker_groups = [
#     {
#       instance_type = "t2.large"
#       asg_max_size  = 1
#       key_name = "ratika"
#     }
#   ]
# }


module "eks_dev_us-east-1_spindevops" {
  source       = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v13.0.0"
  cluster_name    = "eks_dev_us-east-1_spindevops"
  cluster_version = "1.18"
  subnets         = ["subnet-0e38769ceb1c5e312", "subnet-0aaa0d9a5c8a423d2"]
  vpc_id          = "vpc-0fe31fe2fcee00768"
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = ["67.164.73.109/32"]

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 2
      min_capaicty     = 2

      instance_type = "t2.small"
      key_name = "ratika"
    }
  }

  manage_aws_auth = false
}