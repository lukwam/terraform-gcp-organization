#
# Folders
#

# Development Folder
resource "google_folder" "development" {
  display_name = "Development"
  parent       = data.google_organization.org.name
}
output "development_folder_id" {
  value        = google_folder.development.id
}

# Production Folder
resource "google_folder" "production" {
  display_name = "Production"
  parent       = data.google_organization.org.name
}
output "production_folder_id" {
  value        = google_folder.production.id
}
