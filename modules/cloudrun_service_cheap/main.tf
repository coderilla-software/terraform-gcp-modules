
resource "google_cloud_run_service" "service" {
  name     = var.name
  location = var.region
  project  = var.project_id

  template {
      spec {
        container_concurrency = var.container_concurrency
        containers {
          image = var.image

          resources {
            limits = {
              memory = var.memory_limit
              cpu    = var.cpu_limit
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
        
        service_account_name = var.service_account_email
      }
      
      metadata {
        annotations = merge(
          {
            "autoscaling.knative.dev/minScale" = var.min_scale
          },
          var.vpc_connector != null ? {
            "run.googleapis.com/vpc-access-connector" = var.vpc_connector
            "run.googleapis.com/vpc-access-egress" = var.vpc_egress
          } : {}
        )
      }
  }
  
  metadata {
    annotations = {
      "run.googleapis.com/ingress" = var.ingress
    }
  }
}

resource "google_cloud_run_service_iam_member" "invoker" {
  count    = var.allow_public ? 1 : 0
  project  = var.project_id
  location = var.region
  service  = google_cloud_run_service.service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
