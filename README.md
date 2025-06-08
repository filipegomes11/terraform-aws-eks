## Terraform EKS Module

<!-- BEGIN_TF_DOCS -->


## Example

```hcl
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
```
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_cidrs | List of CIDRs allowed to access EKS API | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| cluster\_name | name of the eks cluster | `string` | n/a | yes |
| endpoint\_private\_access | Enable private endpoint access | `bool` | `true` | no |
| endpoint\_public\_access | Enable public endpoint access | `bool` | `true` | no |
| public\_subnets | public subnet to create the cluster | `list(string)` | n/a | yes |
## Outputs

| Name | Description |
|------|-------------|
| eks\_oidc | n/a |
| eks\_vpc\_output | n/a |
## Providers

| Name | Version |
|------|---------|
| aws | 5.99.1 |
| tls | 4.1.0 |
## Requirements

No requirements.
## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_iam_openid_connect_provider.oidc_provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attachment_eks_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group_rule.cluster_sg_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [tls_certificate.eks_oidc](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |
<!-- END_TF_DOCS -->