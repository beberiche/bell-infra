module "vpc" {
  source = "../../modules/vpc"

  common_info      = local.common_info
  common_tags      = local.common_tags
  vpc_info         = local.vpc_info
  eks_cluster_info = local.eks_cluster_info
}

module "eks" {
  source = "../../modules/eks"

  common_info         = local.common_info
  common_tags         = local.common_tags
  vpc_info            = local.vpc_info
  eks_cluster_info    = local.eks_cluster_info
  vpc_id              = module.vpc.vpc_id
  subnets_private_ids = module.vpc.subnets_private_ids
}

module "service" {
  source = "../../modules/service"

  kubernetes_host                   = module.eks.cluster_endpoint
  kubernetes_cluster_ca_certificate = module.eks.cluster_ca_certificate
  kubernetes_token                  = module.eks.cluster_token

  auth_label_app    = local.service_info.auth_label_app
  auth_service_name = local.service_info.auth_service_name
  auth_service_port = local.service_info.auth_service_port
  auth_target_port  = local.service_info.auth_target_port
  auth_service_type = local.service_info.auth_service_type

  users_label_app    = local.service_info.users_label_app
  users_service_name = local.service_info.users_service_name
  users_service_port = local.service_info.users_service_port
  users_target_port  = local.service_info.users_target_port
  users_service_type = local.service_info.users_service_type
}
