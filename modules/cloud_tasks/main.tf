resource "google_cloud_tasks_queue" "this" {
  name     = var.name
  location = var.region
  project  = var.project_id

  rate_limits {
    max_concurrent_dispatches = var.max_concurrent_dispatches
    max_dispatches_per_second = var.max_dispatches_per_second
  }

  retry_config {
    max_attempts = var.max_attempts
    max_retry_duration = var.max_retry_duration
    min_backoff = var.min_backoff
    max_backoff = var.max_backoff
    max_doublings = var.max_doublings
  }
}

# IAM binding to allow Cloud Function to create tasks
# resource "google_cloud_tasks_queue_iam_member" "invoker" {
#   count = length(var.invoker_members)

#   location = google_cloud_tasks_queue.this.location
#   name     = google_cloud_tasks_queue.this.name
#   project  = google_cloud_tasks_queue.this.project
#   role     = "roles/cloudtasks.taskRunner"
#   member   = var.invoker_members[count.index]
# } 