variable "kubernetes_host" {
  description = "kubernetes_host"
  type        = string
}
variable "kubernetes_cluster_ca_certificate" {
  description = "kubernetes_cluster_ca_certificate"
  type        = string
}
variable "kubernetes_token" {
  description = "kubernetes_token"
  type        = string
}

// auth
variable "auth_label_app" {
  description = "The app label to select the pods"
  type        = string
}

variable "auth_service_name" {
  description = "The name of the Kubernetes service"
  type        = string
}

variable "auth_service_port" {
  description = "The port on which the auth service will be exposed"
  type        = number
}

variable "auth_target_port" {
  description = "The port on which the pod(auth) is running"
  type        = number
}

variable "auth_service_type" {
  description = "The type of the service (e.g., ClusterIP, NodePort, LoadBalancer)"
  type        = string
}

// users
variable "users_label_app" {
  description = "The app label to select the pods"
  type        = string
}

variable "users_service_name" {
  description = "The name of the Kubernetes service"
  type        = string
}

variable "users_service_port" {
  description = "The port on which the user service will be exposed"
  type        = number
}

variable "users_target_port" {
  description = "The port on which the pod(user) is running"
  type        = number
}

variable "users_service_type" {
  description = "The type of the service (e.g., ClusterIP, NodePort, LoadBalancer)"
  type        = string
}
