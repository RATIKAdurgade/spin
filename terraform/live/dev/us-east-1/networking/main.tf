provider "aws" {
  region  = "us-east-1"
}

module "vpc" {
  source = "/Users/begining/spin/terraform/modules/vpc"

  name = "SpinDevopsInterview"
  region = "us-east-1"
  key_name = "ratika"
  cidr_block = "10.0.0.0/16"
  private_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.3.0/24"]
  public_subnet_cidr_blocks = ["10.0.0.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  bastion_ami = "ami-0be2609ba883822ec"
  bastion_ebs_optimized = true
  bastion_instance_type = "t3.micro"
  bastion_inbound_cidr_block = ["67.164.73.109/32"]

  project = "Spin"
  environment = "Dev"
  k8s_cluster_name = "eks_dev_us-east-1_spin"
}
