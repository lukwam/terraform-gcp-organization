#
# Org Folders
#

# Development Folder
resource "google_folder" "development" {
  display_name = "Development"
  parent       = data.google_organization.org.name
}
output "development_folder_name" {
  value        = google_folder.development.name
}

# Production Folder
resource "google_folder" "production" {
  display_name = "Production"
  parent       = data.google_organization.org.name
}
output "production_folder_name" {
  value        = google_folder.production.name
}
