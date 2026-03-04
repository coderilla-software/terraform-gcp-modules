variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "env" {
  description = "Environment"
  type        = string
}

variable "name" {
  description = "Name of the Cloud Function"
  type        = string
}

variable "description" {
  description = "Optional description for the function"
  type        = string
  default     = "Generic cloud function"
}

variable "source_zip_path" {
  description = "Path to the zipped Cloud Function source code"
  type        = string
}

variable "entry_point" {
  description = "Entry point (function name) in the Python source"
  type        = string
}

variable "runtime" {
  description = "Runtime environment"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the Cloud Function"
  type        = map(string)
  default     = {}
}

variable "memory" {
  description = "Memory allocation"
  type        = string
  default     = "512M"
}

variable "available_cpu" {
  description = "Available CPU"
  type        = string
  default     = "1"
}

variable "timeout_seconds" {
  description = "Execution timeout"
  type        = number
  default     = 15
}

variable "ingress_settings" {
  description = "Ingress settings (ALLOW_ALL, ALLOW_INTERNAL_ONLY, ALLOW_INTERNAL_AND_GCLB)"
  type        = string
  default     = "ALLOW_ALL"
}

variable "max_instances" {
  description = "Max number of function instances"
  type        = number
  default     = 10
}

variable "max_concurrent_invocations" {
  description = "Max number of concurrent invocations"
  type        = number
  default     = 20
}

variable "labels" {
  description = "Optional labels for the Cloud Function"
  type        = map(string)
  default     = {}
}

variable "service_account_email" {
  description = "Service account email to use for OIDC token (required if send_id_token is true)"
  type        = string
}