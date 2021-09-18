resource "google_storage_bucket" "terraform" {
  name                        = "${var.project_id}-tf"
  location                    = "US"
  project                     = google_project.project.project_id
  force_destroy               = false
  uniform_bucket_level_access = true
}
