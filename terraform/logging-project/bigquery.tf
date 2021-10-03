resource "google_bigquery_dataset" "logging_export" {
  dataset_id    = var.logging_export
  friendly_name = "Logging Export"
  location      = "US"
  project       = var.project_id
}

resource "google_bigquery_dataset_iam_member" "logging_export_editor" {
  dataset_id = google_bigquery_dataset.logging_export.dataset_id
  role       = "roles/editor"
  member     = google_logging_folder_sink.all-audit-logs-to-bigquery.writer_identity
  project    = var.project_id
}
