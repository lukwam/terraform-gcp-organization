#
# Organizational Policy Service
#

# Skip Default Network Creation (Compute)
resource "google_organization_policy" "compute_skip_default_network_creation" {
  org_id     = data.google_organization.org.org_id
  constraint = "constraints/compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}

# Set customer IDs for Domain restricted sharing
resource "google_organization_policy" "iam_allowed_policy_member_domains" {
  org_id     = data.google_organization.org.org_id
  constraint = "constraints/iam.allowedPolicyMemberDomains"

  list_policy {
    allow {
      values = [
        data.google_organization.org.directory_customer_id,
      ]
    }
  }
}

# Disable external IP address access for VM instances
resource "google_organization_policy" "compute_vm_external_ip_access" {
  org_id     = data.google_organization.org.org_id
  constraint = "constraints/compute.vmExternalIpAccess"

  list_policy {
    deny {
      all = true
    }
  }
}
