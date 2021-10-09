resource "google_compute_shared_vpc_host_project" "host" {
  project = google_project.project.project_id
}

resource "google_compute_shared_vpc_service_project" "projects" {
  for_each        = toset(var.vpc_service_projects)
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = each.key
}

data "google_project" "vpc_service_projects" {
  for_each   = toset(var.vpc_service_projects)
  project_id = each.key
}

resource "google_compute_subnetwork_iam_member" "projects-east-private" {
  for_each   = toset(var.vpc_service_projects)
  project    = google_project.project.project_id
  region     = var.east_region
  subnetwork = google_compute_subnetwork.east-private.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.google_project.vpc_service_projects[each.key].number}@cloudservices.gserviceaccount.com"
}

resource "google_compute_subnetwork_iam_member" "projects-east-public" {
  for_each   = toset(var.vpc_service_projects)
  project    = google_project.project.project_id
  region     = var.east_region
  subnetwork = google_compute_subnetwork.east-public.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.google_project.vpc_service_projects[each.key].number}@cloudservices.gserviceaccount.com"
}

resource "google_compute_subnetwork_iam_member" "projects-west-private" {
  for_each   = toset(var.vpc_service_projects)
  project    = google_project.project.project_id
  region     = var.west_region
  subnetwork = google_compute_subnetwork.west-private.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.google_project.vpc_service_projects[each.key].number}@cloudservices.gserviceaccount.com"
}

resource "google_compute_subnetwork_iam_member" "projects-west-public" {
  for_each   = toset(var.vpc_service_projects)
  project    = google_project.project.project_id
  region     = var.west_region
  subnetwork = google_compute_subnetwork.west-public.name
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${data.google_project.vpc_service_projects[each.key].number}@cloudservices.gserviceaccount.com"
}
