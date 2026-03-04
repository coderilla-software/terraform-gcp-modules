resource "google_cloud_scheduler_job" "http_get" {
  name             = var.name
  description      = "Keep Cloud Run service alive"
  schedule         = var.schedule
  time_zone        = "Europe/Berlin"
  attempt_deadline = "320s"

  http_target {
    uri         = var.target_url
    http_method = "GET"
    headers = {
      "User-Agent" = "cloud-scheduler-keepalive"
    }

    dynamic "oidc_token" {
      for_each = var.send_id_token ? [1] : []
      content {
        service_account_email = var.service_account_email
        audience             = var.audience != "" ? var.audience : var.target_url
      }
    }
  }

  project = var.project_id
  region  = var.region
}

