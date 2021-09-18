resource "google_storage_bucket" "terraform" {
  name                        = "${var.project_id}-tf"
  location                    = "US"
  project                     = google_project.project.project_id
  force_destroy               = false
  uniform_bucket_level_access = true
}

data "google_iam_policy" "terraform-bucket" {
  binding {
    role = "roles/storage.admin"
    members = [
      "user:${var.admin_user}@${var.domain_name}",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "terraform" {
  bucket = google_storage_bucket.terraform.name
  policy_data = data.google_iam_policy.terraform-bucket.policy_data
}
