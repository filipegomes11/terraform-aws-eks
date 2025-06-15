output "cluster_name" {
  value       = aws_eks_cluster.this.id
  description = "The name of the EKS Cluster"
}

output "eks_oidc" {
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
  description = "The OIDC value of the cluster"
}

output "certificate_authority" {
  value       = aws_eks_cluster.this.certificate_authority[0].data
  description = "The CA of the eks cluster"
}

output "endpoint" {
  value       = aws_eks_cluster.this.endpoint
  description = "The endpoint of the EKS Cluster"
}
