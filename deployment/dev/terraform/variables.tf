variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-2"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "auth_api_replica_count" {
  description = "Number of replicas for the auth API"
  type        = number
}

variable "auth_api_image_repository" {
  description = "Docker image repository for the auth API"
  type        = string
}

variable "auth_api_service_type" {
  description = "Service type for the auth API"
  type        = string
  default     = "ClusterIP"
}

variable "auth_api_service_port" {
  description = "Service port for the auth API"
  type        = number
}

variable "auth_api_service_targetPort" {
  description = "Service targetPort for the auth API"
  type        = number
}

variable "auth_api_cpu_limit" {
  description = "CPU limit for the auth API"
  type        = string
}

variable "auth_api_memory_limit" {
  description = "Memory limit for the auth API"
  type        = string
}

variable "auth_api_cpu_request" {
  description = "CPU request for the auth API"
  type        = string
}

variable "auth_api_memory_request" {
  description = "Memory request for the auth API"
  type        = string
}

variable "users_api_replica_count" {
  description = "Number of replicas for the users API"
  type        = number
}

variable "users_api_image_repository" {
  description = "Docker image repository for the users API"
  type        = string
}

variable "users_api_service_type" {
  description = "Service type for the users API"
  type        = string
}

variable "users_api_service_port" {
  description = "Service port for the users API"
  type        = number
}

variable "users_api_service_targetPort" {
  description = "Service port for the users API"
  type        = number
}

variable "users_api_cpu_limit" {
  description = "CPU limit for the users API"
  type        = string
}

variable "users_api_memory_limit" {
  description = "Memory limit for the users API"
  type        = string
}

variable "users_api_cpu_request" {
  description = "CPU request for the users API"
  type        = string
}

variable "users_api_memory_request" {
  description = "Memory request for the users API"
  type        = string
}
