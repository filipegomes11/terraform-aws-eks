###providers###

provider "aws" {
  region = "us-east-1"
}

###main.tf###

module "vpc" {
  source     = "filipegomes11/vpc/aws"
  version    = "0.0.2"
  cidr_block = var.cidr_block
  vpc_tags   = var.vpc_tags

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

}

module "eks" {
  source         = "../"
  cluster_name   = var.cluster_name
  public_subnets = module.vpc.public_subnet_ids
  depends_on     = [module.vpc]
}

##variables.tf##

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/24"
}

variable "vpc_tags" {
  type = map(string)
  default = {
    "Name" = "vpc-core"
  }
}

variable "cluster_name" {
  default = "devops-cluster"
}