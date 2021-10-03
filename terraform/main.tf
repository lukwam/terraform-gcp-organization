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
  # project IDs
  tf_project_id                 = "${var.project_prefix}-terraform"
  logging_nonprod_project_id    = "${var.project_prefix}-logging-nonprod"
  logging_prod_project_id       = "${var.project_prefix}-logging-prod"
  monitoring_nonprod_project_id = "${var.project_prefix}-monitoring-nonprod"
  monitoring_prod_project_id    = "${var.project_prefix}-monitoring-prod"
  vpc_host_nonprod_project_id   = "${var.project_prefix}-vpc-host-nonprod"
  vpc_host_prod_project_id      = "${var.project_prefix}-vpc-host-prod"
  # bigquery dataset ids
  logging_export_nonprod        = "${var.project_prefix}_logging_export_nonprod"
  logging_export_prod           = "${var.project_prefix}_logging_export_prod"
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
  logging_export  = local.logging_export_nonprod
}

module "logging-prod-project" {
  source          = "./logging-project"
  billing_account = module.billing.billing_account_name
  domain_name     = var.domain_name
  folder_id       = module.org.prod_folder_id
  project_id      = local.logging_prod_project_id
  project_name    = "Logging - Production"
  logging_export  = local.logging_export_prod
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
  source                = "./vpc-host-project"
  billing_account       = module.billing.billing_account_name
  domain_name           = var.domain_name
  folder_id             = module.org.nonprod_folder_id
  project_id            = local.vpc_host_nonprod_project_id
  project_name          = "VPC Host - Non-Production"
  project_prefix        = "${var.project_prefix}-nonprod"
  vpc_network_name      = "${var.project_prefix}-shared-vpc-nonprod-1"
  east_public_ip_range  = "10.1.0.0/24"
  east_private_ip_range = "10.2.0.0/24"
  east_region           = "us-east1"
  west_public_ip_range  = "10.3.0.0/24"
  west_private_ip_range = "10.4.0.0/24"
  west_region           = "us-west1"
  vpc_service_projects  = [
    local.logging_nonprod_project_id,
    local.monitoring_nonprod_project_id
  ]
}

module "vpc-host-prod-project" {
  source           = "./vpc-host-project"
  billing_account  = module.billing.billing_account_name
  domain_name      = var.domain_name
  folder_id        = module.org.prod_folder_id
  project_id       = local.vpc_host_prod_project_id
  project_name     = "VPC Host - Production"
  project_prefix        = "${var.project_prefix}-prod"
  vpc_network_name = "${var.project_prefix}-shared-vpc-prod-1"
  east_public_ip_range  = "10.1.0.0/24"
  east_private_ip_range = "10.2.0.0/24"
  east_region           = "us-east1"
  west_public_ip_range  = "10.3.0.0/24"
  west_private_ip_range = "10.4.0.0/24"
  west_region           = "us-west1"
  vpc_service_projects  = [
    local.logging_prod_project_id,
    local.monitoring_prod_project_id
  ]
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
