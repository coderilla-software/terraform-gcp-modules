output "url" {
  value = google_cloud_run_service.service.status[0].url
}

output "internal_url" {
  value = google_cloud_run_service.service.status[0].url
}

output "name" {
  value = google_cloud_run_service.service.name
}