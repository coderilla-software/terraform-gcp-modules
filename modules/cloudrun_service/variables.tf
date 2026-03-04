variable "name" {
  type = string
  description = "The name of the service"
}

variable "image" {
  type = string
  description = "The docker image"
}

variable "region" {
  type = string
  description = "The region for the service"
}

variable "project_id" {
  type = string
  description = "The project ID for the service"
}

variable "env_vars" {
  description = "The environment variables for the service"
  type = map(string)
  default = {}
}

variable "service_account_email" {
  description = "The service account email for the service"
  type = string
}

variable "ingress" {
  type    = string
  description = "The ingress setting for the service"
}

variable "allow_public" {
  description = "Whether to allow public access to the service"
  type = bool
  default = false
}

variable "cpu_limit" {
  type = string
  description = "The CPU limit for the service"
  default = "1"
}

variable "memory_limit" {
  type = string
  description = "The memory limit for the service"
  default = "512Mi"
}

variable "vpc_connector" {
  type        = string
  default     = null
  description = "Optional VPC connector to attach to the service"
}

variable "vpc_egress" {
  type        = string
  default     = "ALL_TRAFFIC"
  description = "Egress setting for VPC connector: ALL_TRAFFIC or PRIVATE_RANGES_ONLY"
}
