resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.project_id
}

# resource "google_compute_subnetwork" "subnet" {
#   name                     = var.subnet_name
#   ip_cidr_range            = var.subnet_ip_range
#   region                   = var.region
#   network                  = google_compute_network.vpc.id
#   project                  = var.project_id
#   private_ip_google_access = true
# }

resource "google_vpc_access_connector" "vpc_connector" {
  name         = var.connector_name
  region       = var.region
  project      = var.project_id
  network      = google_compute_network.vpc.name
  ip_cidr_range = var.subnet_ip_range

  machine_type  = "e2-micro"      # ✅ Cost-efficient
  min_instances = 2               # ✅ Keeps baseline low
  max_instances = 3
}


