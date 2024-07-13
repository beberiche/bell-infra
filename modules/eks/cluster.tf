resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_info.cluster_name
  role_arn = aws_iam_role.master_role.arn
  version  = var.eks_cluster_info.cluster_version

  kubernetes_network_config {
    service_ipv4_cidr = var.eks_cluster_info.cluster_service_ipv4_cidr
  }

  vpc_config {
    security_group_ids      = [aws_security_group.cluster_sg.id]
    subnet_ids              = var.subnets_private_ids
    endpoint_public_access  = var.eks_cluster_info.cluster_endpoint_public_access
    endpoint_private_access = var.eks_cluster_info.cluster_endpoint_private_access
  }

  enabled_cluster_log_types = var.eks_cluster_info.cluster_enabled_cluster_log_types

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]

  tags = {
    Name = var.eks_cluster_info.cluster_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks_cluster.name
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.name
}
