output "stripe_webhook_proxy_url" {
  description = "Public HTTPS URL of the deployed Cloud Function"
  value       = google_cloudfunctions2_function.proxy.service_config[0].uri
}

output "name" {
  description = "Deployed function name"
  value       = google_cloudfunctions2_function.proxy.name
}