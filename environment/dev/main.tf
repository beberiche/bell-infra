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
