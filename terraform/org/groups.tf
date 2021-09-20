variable "groups" {
  default = {
    "gcp-billing-admins": {
      "display_name": "gcp-billing-admins",
      "description": "Billing administrators are responsible for setting up billing accounts and monitoring their usage.",
    },
    "gcp-developers": {
      "display_name": "gcp-developers",
      "description": "Developers are responsible for designing, coding, and testing applications.",
    },
    "gcp-devops": {
      "display_name": "gcp-devops",
      "description": "DevOps practitioners create or manage end-to-end pipelines that support continuous integration and delivery, monitoring, and system provisioning.",
    },
    "gcp-network-admins": {
      "display_name": "gcp-network-admins",
      "description": "Network administrators are responsible for creating networks, subnets, firewall rules, and network devices such as cloud routers, Cloud VPN instances, and load balancers.",
    },
    "gcp-organization-admins": {
      "display_name": "gcp-organization-admins",
      "description": "Organization administrators are responsible for organizing the structure of the resources used by the organization.",
    },
    "gcp-security-admins": {
      "display_name": "gcp-security-admins",
      "description": "Security administrators are responsible for establishing and managing security policies for the entire organization, including access management and organization constraint policies.",
    },
    "terraform-admins": {
      "display_name": "terraform-admins",
      "description": "Terraform administrators with access to manage terraform state and organizational resources."
    }
}
}
resource "google_cloud_identity_group" "groups" {
  provider             = google.sa
  for_each             = var.groups
  display_name         = each.value["display_name"]
  description          = each.value["description"]
  initial_group_config = "WITH_INITIAL_OWNER"

  parent = "customers/${data.google_organization.org.directory_customer_id}"

  group_key {
    id = "${each.key}@${var.domain_name}"
  }

  labels = {
    "cloudidentity.googleapis.com/groups.discussion_forum" = ""
  }
}
