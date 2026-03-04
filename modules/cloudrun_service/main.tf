resource "google_cloud_run_v2_service" "service" {
  project = var.project_id
  name     = var.name
  location = var.region

  template {
    containers {
      image = var.image

      resources {
        limits = {
          cpu    = var.cpu_limit
          memory = var.memory_limit
        }
      }

      dynamic "env" {
        for_each = var.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }
    }
    service_account = var.service_account_email

    dynamic "vpc_access" {
      for_each = var.vpc_connector != null ? [1] : []
      content {
        connector = var.vpc_connector
        egress    = var.vpc_egress
      }
    }
  }

  ingress = var.ingress
  deletion_protection = false
}

resource "google_cloud_run_v2_service_iam_member" "invoker" {
  project = var.project_id
  count = var.allow_public ? 1 : 0
  location = var.region

  name = google_cloud_run_v2_service.service.name
  role    = "roles/run.invoker"
  member  = "allUsers"
}
