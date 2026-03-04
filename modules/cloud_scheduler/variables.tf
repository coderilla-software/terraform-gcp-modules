variable "name" {
  description = "The name of the Cloud Scheduler job"
  type        = string
}

variable "target_url" {
  description = "The URL to ping"
  type        = string
}

variable "schedule" {
  description = "Cron schedule (e.g. every 12 mins)"
  type        = string
  default     = "*/12 * * * *"
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "send_id_token" {
  description = "Whether to send an OIDC ID token with the request"
  type        = bool
  default     = false
}

variable "service_account_email" {
  description = "Service account email to use for OIDC token (required if send_id_token is true)"
  type        = string
  default     = ""
}

variable "audience" {
  description = "OIDC audience for the ID token (usually your target_url)"
  type        = string
  default     = ""
}
