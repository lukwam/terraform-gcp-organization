resource "google_service_account" "terraform" {
  account_id   = "terraform"
  display_name = "Terraform Service Account"
  project      = google_project.project.project_id
}

resource "google_service_account_key" "terraform" {
  service_account_id = google_service_account.terraform.name
}
output "service_account_key" {
  value = google_service_account_key.terraform.private_key
}

data "google_iam_policy" "admin-sa-user" {
  binding {
    role = "roles/iam.serviceAccountTokenCreator"
    members = [
      "user:${var.admin_user}@${var.domain_name}",
    ]
  }
}

resource "google_service_account_iam_policy" "admin-account-iam" {
  service_account_id = google_service_account.terraform.name
  policy_data        = data.google_iam_policy.admin-sa-user.policy_data
}
