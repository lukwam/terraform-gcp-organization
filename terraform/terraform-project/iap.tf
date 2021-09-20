resource "google_iap_brand" "project" {
  application_title = "Terraform"
  project           = google_project.project.number
  support_email     = "${var.admin_user}@${var.domain_name}"

  depends_on = [
    google_project_service.services["iap.googleapis.com"]
  ]
}
