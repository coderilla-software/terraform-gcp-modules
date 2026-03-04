resource "google_cloud_run_domain_mapping" "custom_domain" {
  project  = var.project_id
  location = var.region
  
  name     = var.domain_name  # e.g., staging.scribe-spark.com

  metadata {
    namespace = var.project_id
  }

  spec {
    route_name = var.cloud_run_service_name
  }
}
