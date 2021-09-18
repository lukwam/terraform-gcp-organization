#
# Essential Contacts
#

resource "google_essential_contacts_contact" "org" {
  provider     = google.sa
  parent       = data.google_organization.org.name
  email        = var.org_contact
  language_tag = "en-US"
  notification_category_subscriptions = ["ALL"]
}
