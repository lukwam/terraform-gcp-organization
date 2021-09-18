# IAM Policy and Audit Log default config
resource "google_organization_iam_policy" "org" {
  org_id      = data.google_organization.org.org_id
  policy_data = data.google_iam_policy.org.policy_data
}

data "google_iam_policy" "org" {

  audit_config {
    service = "allServices"

    audit_log_configs {
      log_type = "ADMIN_READ"
    }

    audit_log_configs {
      log_type = "DATA_READ"
    }

    audit_log_configs {
      log_type = "DATA_WRITE"
    }
  }

  binding {
    role = "roles/billing.creator"
    members = [
      "domain:${var.domain_name}",
    ]
  }

  binding {
    role = "roles/orgpolicy.policyAdmin"

    members = [
      # "group:gcp-organization-admins@lukwam.dev",
      # "group:gcp-security-admins@lukwam.dev",
      "user:admin@test.lukwam.dev",
    ]
  }

  binding {
    role = "roles/resourcemanager.folderAdmin"
    members = [
      "user:${var.admin_user}@${var.domain_name}",
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
