resource "google_project" "project" {
  name                = var.project_name
  project_id          = var.project_id
  folder_id           = var.folder_id
  billing_account     = var.billing_account

  labels = {
    billing           = lower(var.billing_account),
  }

  auto_create_network = false
  skip_delete         = false
}

resource "google_project_service" "services" {
  for_each = toset([
    "bigquery.googleapis.com",
  ])
  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.project.project_id
}

resource "google_project_iam_member" "project" {
  project = google_project.project.project_id
  role    = "roles/owner"
  member  = "group:gcp-devops@${var.domain_name}"
}
