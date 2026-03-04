variable "domain_name" {
  description = "The custom domain/subdomain to map to Cloud Run"
  type        = string
}

variable "region" {
  description = "Region of the Cloud Run service"
  type        = string
}
variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "cloud_run_service_name" {
  description = "Cloud Run service name"
  type        = string
}