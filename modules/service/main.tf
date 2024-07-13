provider "kubernetes" {
  host                   = var.kubernetes_host
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
  token                  = var.kubernetes_token
}

resource "kubernetes_service" "auth_service" {
  metadata {
    name      = var.auth_service_name
    namespace = "default"
  }

  spec {
    selector = {
      app = var.auth_label_app
    }

    port {
      port        = var.auth_service_port
      target_port = var.auth_target_port
    }

    type = var.auth_service_type
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "kubernetes_service" "users_service" {
  metadata {
    name      = var.users_service_name
    namespace = "default"
  }

  spec {
    selector = {
      app = var.users_label_app
    }

    port {
      port        = var.users_service_port
      target_port = var.users_target_port
    }

    type = var.users_service_type
  }

  lifecycle {
    create_before_destroy = true
  }
}
