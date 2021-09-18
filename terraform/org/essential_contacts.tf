#
# Essential Contacts
#

# resource "google_essential_contacts_contact" "org" {
#   parent       = "organizations/${data.google_organization.org.org_id}"
#   email        = var.org_contact
#   language_tag = "en-US"
#   notification_category_subscriptions = ["ALL"]
# }
