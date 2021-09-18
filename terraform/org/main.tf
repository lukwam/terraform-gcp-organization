# Retrieve the organization resource based on domain name
data "google_organization" "org" {
  domain = var.domain_name
}

# Set the customer_id and organization_id as output values
output "customer_id" {
  value = data.google_organization.org.directory_customer_id
}
output "organization_id" {
  value = data.google_organization.org.org_id
}
