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

module "org" {
  source      = "./org"
  admin_user  = var.admin_user
  domain_name = var.domain_name
  # groups      = var.groups
  # org_viewers = var.org_viewers
  # project_id  = var.terraform_project_id
}

variable "admin_user" {
  default = "admin"
}
variable "domain_name" {}

# Outputs
output "customer_id" {
  value = module.org.customer_id
}
output "organization_id" {
  value = module.org.organization_id
}