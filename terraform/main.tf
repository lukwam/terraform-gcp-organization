terraform {
  # backend "gcs" {
  #   bucket = "lukwam-terraform"
  # }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.84.0"
    }
    # google-beta = {
    #   source  = "hashicorp/google-beta"
    #   version = "3.84.0"
    # }
  }
}

provider "google" {
  alias = "default"
  # credentials = file(var.credentials_file)
  # project     = var.terraform_project_id
}

provider "google" {
  alias = "sa"
  # credentials = file(var.credentials_file)
  # project     = var.terraform_project_id
  impersonate_service_account = "terraform@${var.tf_project_id}.iam.gserviceaccount.com"
}

module "billing" {
  source                       = "./billing"
  billing_account_display_name = var.billing_account_display_name
}

module "org" {
  source        = "./org"
  admin_user    = var.admin_user
  domain_name   = var.domain_name
  org_contact   = var.org_contact
  tf_project_id = var.tf_project_id
  providers     = {
    google      = google.default
    google.sa   = google.sa
  }
}

module "terraform-project" {
  source          = "./terraform-project"
  admin_user      = var.admin_user
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.production_folder_id
  project_id      = var.tf_project_id
  project_name    = var.tf_project_name
}

# Outputs
output "billing_account_name" {
  value = module.billing.billing_account_name
}
output "customer_id" {
  value = module.org.customer_id
}
output "organization_id" {
  value = module.org.organization_id
}
output "folder_development" {
  value = module.org.development_folder_id
}
output "folder_production" {
  value = module.org.production_folder_id
}
