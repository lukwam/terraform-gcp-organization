resource "google_logging_folder_sink" "all-audit-logs-to-bigquery" {
  name             = "all-audit-logs-to-bigquery"
  description      = "Send all audit logs to BigQuery"
  folder           = var.folder_id
  include_children = true

  # Can export to pubsub, cloud storage, or bigquery
  destination = "bigquery.googleapis.com/projects/${var.project_id}/datasets/${var.logging_export}"

  # Log all WARN or higher severity messages relating to instances
  filter = <<EOT
    logName:"cloudaudit.googleapis.com%2Factivity"
      OR logName:"cloudaudit.googleapis.com%2Fpolicy"
      OR logName:"cloudaudit.googleapis.com%2Fdata_access"
      OR logName:"cloudaudit.googleapis.com%2Faccess_transparency"
      OR logName:"dns.googleapis.com%2Fdns_queries"
      OR resource.type="nat_gateway"
      OR (logName:"compute.googleapis.com%2Fvpc_flows" AND resource.type="gce_subnetwork")
      OR (logName:"compute.googleapis.com%2Ffirewall" AND resource.type="gce_subnetwork")
      OR (logName:"requests" AND resource.type="http_load_balancer")
      OR (log_id("syslog") AND resource.type="gce_instance")
      OR (log_id("winevt.raw") AND resource.type="gce_instance")
    EOT
}
