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
  # credentials = file(var.credentials_file)
  # project     = var.terraform_project_id
}

module "billing" {
  source                       = "./billing"
  billing_account_display_name = var.billing_account_display_name
}

module "org" {
  source      = "./org"
  admin_user  = var.admin_user
  domain_name = var.domain_name
  # groups      = var.groups
  # org_viewers = var.org_viewers
  # project_id  = var.terraform_project_id
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
