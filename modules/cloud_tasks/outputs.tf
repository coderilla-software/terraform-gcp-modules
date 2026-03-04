output "queue_name" {
  description = "Name of the Cloud Tasks queue"
  value       = google_cloud_tasks_queue.this.name
}

output "queue_location" {
  description = "Location of the Cloud Tasks queue"
  value       = google_cloud_tasks_queue.this.location
}

output "queue_id" {
  description = "ID of the Cloud Tasks queue"
  value       = google_cloud_tasks_queue.this.id
} 