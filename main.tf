resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = var.public_subnets
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  depends_on = [
    aws_iam_role_policy_attachment.attachment_eks_role_policy,
  ]

  tags = merge(local.tags, { Name = var.cluster_name })
}
