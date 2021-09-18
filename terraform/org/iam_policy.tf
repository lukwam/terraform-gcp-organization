# IAM Policy and Audit Log default config
resource "google_organization_iam_policy" "org" {
  org_id      = data.google_organization.org.org_id
  policy_data = data.google_iam_policy.org.policy_data
}

data "google_iam_policy" "org" {

  binding {
    role = "roles/billing.creator"
    members = [
      "domain:${var.domain_name}",
    ]
  }

  binding {
    role = "roles/resourcemanager.organizationAdmin"
    members = [
      "user:${var.admin_user}@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/resourcemanager.projectCreator"
    members = [
      "domain:${var.domain_name}",
    ]
  }

}
