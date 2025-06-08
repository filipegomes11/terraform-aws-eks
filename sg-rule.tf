resource "aws_security_group_rule" "cluster_sg_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidrs
  security_group_id = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  description       = "Allow EKS API access from allowed CIDRs"
}
