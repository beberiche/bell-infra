provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

resource "helm_release" "api-release" {
  name      = "api-release"
  chart     = "../charts/api"
  namespace = "default"

  // auth-deployment
  set {
    name  = "authApi.replicaCount"
    value = var.auth_api_replica_count
  }

  set {
    name  = "authApi.image.repository"
    value = var.auth_api_image_repository
  }

  set {
    name  = "authApi.resources.limits.cpu"
    value = var.auth_api_cpu_limit
  }

  set {
    name  = "authApi.resources.limits.memory"
    value = var.auth_api_memory_limit
  }

  set {
    name  = "authApi.resources.requests.cpu"
    value = var.auth_api_cpu_request
  }

  set {
    name  = "authApi.resources.requests.memory"
    value = var.auth_api_memory_request
  }

  // user-deplyment
  set {
    name  = "usersApi.replicaCount"
    value = var.users_api_replica_count
  }

  set {
    name  = "usersApi.image.repository"
    value = var.users_api_image_repository
  }

  set {
    name  = "usersApi.resources.limits.cpu"
    value = var.users_api_cpu_limit
  }

  set {
    name  = "usersApi.resources.limits.memory"
    value = var.users_api_memory_limit
  }

  set {
    name  = "usersApi.resources.requests.cpu"
    value = var.users_api_cpu_request
  }

  set {
    name  = "usersApi.resources.requests.memory"
    value = var.users_api_memory_request
  }
}
