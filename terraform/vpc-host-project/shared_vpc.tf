resource "google_compute_shared_vpc_host_project" "host" {
  project = var.project_id
}

resource "google_compute_shared_vpc_service_project" "projects" {
  for_each        = toset(var.vpc_service_projects)
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = each.key
}
