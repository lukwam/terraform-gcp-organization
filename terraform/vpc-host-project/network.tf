resource "google_compute_network" "vpc" {
  project                 = google_project.project.project_id
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "east-private" {
  name                     = "${var.project_prefix}-${var.east_region}-subnet-private"
  project                  = google_compute_network.vpc.project
  ip_cidr_range            = var.east_private_ip_range
  region                   = var.east_region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "east-public" {
  name                     = "${var.project_prefix}-${var.east_region}-subnet-public"
  project                  = google_compute_network.vpc.project
  ip_cidr_range            = var.east_public_ip_range
  region                   = var.east_region
  network                  = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "west-private" {
  name                     = "${var.project_prefix}-${var.west_region}-subnet-private"
  project                  = google_compute_network.vpc.project
  ip_cidr_range            = var.west_private_ip_range
  region                   = var.west_region
  network                  = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "west-public" {
  name                     = "${var.project_prefix}-${var.west_region}-subnet-public"
  project                  = google_compute_network.vpc.project
  ip_cidr_range            = var.west_public_ip_range
  region                   = var.west_region
  network                  = google_compute_network.vpc.id
}

# data "google_iam_policy" "admin" {
#   binding {
#     role = "roles/compute.networkUser"
#     members = [
#       "user:jane@example.com",
#     ]
#   }
# }

# resource "google_compute_subnetwork_iam_policy" "policy" {
#   project     = google_compute_subnetwork.east-private.project
#   region      = google_compute_subnetwork.east-private.region
#   subnetwork  = google_compute_subnetwork.east-private.name
#   policy_data = data.google_iam_policy.admin.policy_data
# }
