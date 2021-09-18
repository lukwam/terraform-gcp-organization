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
    "cloudbilling.googleapis.com",
    "cloudidentity.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "essentialcontacts.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-api.googleapis.com",
    "storage.googleapis.com",
  ])
  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = true
  project                    = google_project.project.project_id
}

resource "google_service_account" "terraform" {
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  project      = google_project.project.project_id
}

resource "google_project_iam_member" "terraform" {
  for_each = toset([
    "roles/owner",
    "roles/storage.admin",
  ])
  project  = google_project.project.project_id
  role     = each.key
  member   = "serviceAccount:${google_service_account.terraform.email}"
}