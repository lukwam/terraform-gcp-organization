#
# Folders
#

# Non-Production Folder
resource "google_folder" "non-production" {
  display_name = "Non-Production"
  parent       = data.google_organization.org.name
}
output "nonprod_folder_id" {
  value        = google_folder.non-production.id
}
resource "google_folder_iam_policy" "non-production" {
  folder      = google_folder.non-production.id
  policy_data = data.google_iam_policy.non-production-folder.policy_data
}
data "google_iam_policy" "non-production-folder" {
  binding {
    role = "roles/compute.admin"
    members = [
      "group:gcp-developers@${var.domain_name}",
    ]
  }
  binding {
    role = "roles/container.admin"
    members = [
      "group:gcp-developers@${var.domain_name}",
    ]
  }
}

# Non-Production Shared Folder
resource "google_folder" "non-production-shared" {
  display_name = "Shared"
  parent       = google_folder.non-production.name
}
output "nonprod_shared_folder_id" {
  value        = google_folder.non-production-shared.id
}

# Production Folder
resource "google_folder" "production" {
  display_name = "Production"
  parent       = data.google_organization.org.name
}
output "prod_folder_id" {
  value        = google_folder.production.id
}
resource "google_folder_iam_policy" "production" {
  folder      = google_folder.production.id
  policy_data = data.google_iam_policy.production-folder.policy_data
}
data "google_iam_policy" "production-folder" {
  binding {
    role = "roles/compute.admin"
    members = [
      "group:gcp-devops@${var.domain_name}",
    ]
  }
  binding {
    role = "roles/container.admin"
    members = [
      "group:gcp-devops@${var.domain_name}",
    ]
  }
  binding {
    role = "roles/errorreporting.admin"
    members = [
      "group:gcp-devops@${var.domain_name}",
    ]
  }
  binding {
    role = "roles/logging.admin"
    members = [
      "group:gcp-devops@${var.domain_name}",
    ]
  }
  binding {
    role = "roles/monitoring.admin"
    members = [
      "group:gcp-devops@${var.domain_name}",
    ]
  }
  binding {
    role = "roles/servicemanagement.quotaAdmin"
    members = [
      "group:gcp-devops@${var.domain_name}",
    ]
  }
}

# Production Shared Folder
resource "google_folder" "production-shared" {
  display_name = "Shared"
  parent       = google_folder.production.name
}
output "prod_shared_folder_id" {
  value        = google_folder.production-shared.id
}
