# Deploys a generic Cloud Function (Gen2) that proxies external requests into internal services.

resource "google_storage_bucket" "function_bucket" {
  name                        = "${var.project_id}-${var.env}-functions"
  location                    = var.region
  uniform_bucket_level_access = true
}

# Upload the zipped function code
resource "google_storage_bucket_object" "function_archive" {
  name   = "${var.name}-${timestamp()}.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = var.source_zip_path
}

resource "google_cloudfunctions2_function" "proxy" {
  name        = var.name
  location    = var.region
  description = var.description

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"

    source {
      storage_source {
        bucket = google_storage_bucket.function_bucket.name
        object = google_storage_bucket_object.function_archive.name
      }
    }
  }

  service_config {
    available_memory   = var.memory
    available_cpu      = var.available_cpu
    timeout_seconds    = var.timeout_seconds
    ingress_settings   = var.ingress_settings
    max_instance_count = var.max_instances
    max_instance_request_concurrency = var.max_concurrent_invocations

    environment_variables = var.environment_variables
    service_account_email = var.service_account_email
  }

  labels = var.labels
}

resource "google_cloud_run_service_iam_member" "public_invoker" {
  location = google_cloudfunctions2_function.proxy.location
  project  = google_cloudfunctions2_function.proxy.project
  service  = google_cloudfunctions2_function.proxy.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
