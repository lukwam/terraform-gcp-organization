#
# Organizational Policy Service
#

# Require OS Login (Compute)
resource "google_organization_policy" "compute_require_os_login" {
  org_id     = data.google_organization.org.org_id
  constraint = "constraints/compute.requireOsLogin"

  boolean_policy {
    enforced = true
  }
}

# Skip Default Network Creation (Compute)
resource "google_organization_policy" "compute_skip_default_network_creation" {
  org_id     = data.google_organization.org.org_id
  constraint = "constraints/compute.skipDefaultNetworkCreation"

  boolean_policy {
    enforced = true
  }
}
