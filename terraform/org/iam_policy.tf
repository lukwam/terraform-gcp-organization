#
# IAM Policy and Audit Log default config
#

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
    role = "roles/bigquery.dataViewer"
    members = [
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/billing.admin"
    members = [
      "group:gcp-billing-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/billing.creator"
    members = [
      "domain:${var.domain_name}",
      "group:gcp-billing-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/billing.user"
    members = [
      "group:gcp-organization-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/cloudsupport.admin"
    members = [
      "group:gcp-organization-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/compute.networkAdmin"
    members = [
      "group:gcp-network-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/compute.securityAdmin"
    members = [
      "group:gcp-network-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/compute.viewer"
    members = [
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/compute.xpnAdmin"
    members = [
      "group:gcp-network-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/container.viewer"
    members = [
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/essentialcontacts.admin"
    members = [
      "serviceAccount:terraform@${var.tf_project_id}.iam.gserviceaccount.com",
      "user:${var.admin_user}@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/iam.organizationRoleAdmin"
    members = [
      "group:gcp-organization-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/iam.organizationRoleViewer"
    members = [
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/iam.securityReviewer"
    members = [
       "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/logging.configWriter"
    members = [
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/logging.privateLogViewer"
    members = [
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/orgpolicy.policyAdmin"
    members = [
      "group:gcp-organization-admins@${var.domain_name}",
      "group:gcp-security-admins@${var.domain_name}",
      "user:${var.admin_user}@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/orgpolicy.policyViewer"
    members = [
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/resourcemanager.folderAdmin"
    members = [
      "group:gcp-organization-admins@${var.domain_name}",
      "user:${var.admin_user}@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/resourcemanager.folderIamAdmin"
    members = [
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/resourcemanager.folderViewer"
    members = [
      "group:gcp-devops@${var.domain_name}",
      "group:gcp-network-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/resourcemanager.organizationAdmin"
    members = [
      "group:gcp-organization-admins@${var.domain_name}",
      "user:${var.admin_user}@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/resourcemanager.organizationViewer"
    members = [
      "group:gcp-billing-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/resourcemanager.projectCreator"
    members = [
      "domain:${var.domain_name}",
      "group:gcp-organization-admins@${var.domain_name}",
    ]
  }

  binding {
    role = "roles/securitycenter.admin"
    members = [
      "group:gcp-organization-admins@${var.domain_name}",
      "group:gcp-security-admins@${var.domain_name}",
    ]
  }

  # binding {
  #   role = "roles/securitycenter.serviceAgent"
  #   members = [
  #     "serviceAccount:service-org-${data.google_organization.org.org_id}@security-center-api.iam.gserviceaccount.com",
  #   ]
  # }

  # binding {
  #   role = "roles/serviceusage.serviceUsageAdmin"
  #   members = [
  #     "serviceAccount:service-org-${data.google_organization.org.org_id}@security-center-api.iam.gserviceaccount.com",
  #   ]
  # }

}
