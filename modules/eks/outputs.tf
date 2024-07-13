output "cluster_endpoint" {
  value       = data.aws_eks_cluster.cluster.endpoint
  description = "The endpoint for the EKS cluster"
}

output "cluster_ca_certificate" {
  value       = data.aws_eks_cluster.cluster.certificate_authority[0].data
  description = "The certificate authority data for the EKS cluster"
}

output "cluster_token" {
  value       = data.aws_eks_cluster_auth.cluster.token
  description = "The authentication token for the EKS cluster"
}
