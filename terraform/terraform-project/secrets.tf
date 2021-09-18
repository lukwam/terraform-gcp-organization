resource "google_secret_manager_secret" "service-account-key" {
  secret_id = "service-account-key"
  project   = var.project_id
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "service-account-key" {
  secret      = google_secret_manager_secret.service-account-key.id
  secret_data = google_service_account_key.terraform.private_key
}
