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
  impersonate_service_account = "terraform@${local.tf_project_id}.iam.gserviceaccount.com"
}

locals {
  # generate project IDs for various service projects
  tf_project_id                 = "${var.project_prefix}-terraform"
  logging_nonprod_project_id    = "${var.project_prefix}-logging-nonprod"
  logging_prod_project_id       = "${var.project_prefix}-logging-prod"
  monitoring_nonprod_project_id = "${var.project_prefix}-monitoring-nonprod"
  monitoring_prod_project_id    = "${var.project_prefix}-monitoring-prod"
  vpc_host_nonprod_project_id   = "${var.project_prefix}-vpc-host-nonprod"
  vpc_host_prod_project_id      = "${var.project_prefix}-vpc-host-prod"
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
  tf_project_id = local.tf_project_id
  providers     = {
    google      = google.default
    google.sa   = google.sa
  }
}

module "logging-nonprod-project" {
  source          = "./logging-project"
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.nonprod_folder_id
  project_id      = local.logging_nonprod_project_id
  project_name    = "Logging - Non-Production"
}

module "logging-prod-project" {
  source          = "./logging-project"
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.prod_folder_id
  project_id      = local.logging_prod_project_id
  project_name    = "Logging - Production"
}

module "monitoring-nonprod-project" {
  source          = "./monitoring-project"
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.nonprod_folder_id
  project_id      = local.monitoring_nonprod_project_id
  project_name    = "Monitoring - Non-Production"
}

module "monitoring-prod-project" {
  source          = "./monitoring-project"
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.prod_folder_id
  project_id      = local.monitoring_prod_project_id
  project_name    = "Monitoring - Production"
}

module "vpc-host-nonprod-project" {
  source          = "./vpc-host-project"
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.nonprod_folder_id
  project_id      = local.vpc_host_nonprod_project_id
  project_name    = "VPC Host - Non-Production"
}

module "vpc-host-prod-project" {
  source          = "./vpc-host-project"
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.prod_folder_id
  project_id      = local.vpc_host_prod_project_id
  project_name    = "VPC Host - Production"
}

module "terraform-project" {
  source          = "./terraform-project"
  admin_user      = var.admin_user
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.prod_folder_id
  project_id      = local.tf_project_id
  project_name    = "Terraform"
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
