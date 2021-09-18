# Rerieve billing account based on display name
data "google_billing_account" "default" {
  display_name = var.billing_account_display_name
  open         = true
}

# Set the billing account name as output
output "billing_account_name" {
  value = data.google_billing_account.default.id
}
