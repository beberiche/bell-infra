resource "aws_eks_node_group" "eks_nodegroup" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.eks_cluster_info.nodegroup_name
  node_role_arn   = aws_iam_role.nodegroup_role.arn
  subnet_ids      = var.subnets_private_ids

  ami_type       = var.eks_cluster_info.nodegroup_ami_type
  disk_size      = var.eks_cluster_info.nodegroup_disk_size
  instance_types = var.eks_cluster_info.nodegroup_instance_types

  labels = {
    nodegroup-type = var.eks_cluster_info.nodegroup_name
  }

  scaling_config {
    desired_size = var.eks_cluster_info.nodegroup_desired_size
    max_size     = var.eks_cluster_info.nodegroup_max_size
    min_size     = var.eks_cluster_info.nodegroup_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = var.eks_cluster_info.nodegroup_name
  }
}
