# terraform-gcp-organization

Example Terraform Config for a Google Cloud Platform (GCP) Organization

## Summary

This terraform configuration is based off of the Google Cloud Platform checklist for setting up a new Organization.

https://console.cloud.google.com/getting-started/enterprise

## Checklist

Items marked with "✅" are managed by this Terraform configuration.

### 1. Setup your organization resource
1. Sign up for Google Workspace or Google Cloud Identity
1. Verify your domain to Google Cloud organization resource

### 2. Add users and groups to your
1. Add users
1. Add groups
   * `gcp-organization-admins` ✅
   * `gcp-network-admins` ✅
   * `gcp-billing-admins` ✅
   * `gcp-security-admins` ✅
   * `gcp-devops` ✅
   * `gcp-developers` ✅
1. Add users to groups

### 3. Set up administrator access to your organization
1. Grant the Organization Administrator role to the `gcp-organization-admins` group ✅

### 4. Set up billing
1. Grant the Billing Administrator role to the `gcp-billing-admins` group ✅
1. Create a new billing account or migrate an existing billing account into the organization

### 5. Set up the resource hierarchy
1. Plan the resource hierarchy
1. Create initial folders of the resource hierarchy
   * `Non-Production` ✅
   * `Non-Production/Shared` ✅
   * `Production` ✅
   * `Production/Shared` ✅
1. Create initial projects of the resource hierarchy
   * `example-vpc-host-nonprod` in `Non-Production` ✅
   * `example-vpc-host-prod` in `Production` ✅
   * `example-monitoring-nonprod` in `Non-Production` ✅
   * `example-monitoring-prod` in `Production` ✅
   * `example-logging-nonprod` in `Non-Production` ✅
   * `example-logging-prod` in `Production` ✅
1. Confirm projects are linked to the appropriate billing account ✅

### 6. Set up access control for your resource hierarchy
1. Set IAM policies at the organization level ✅
   * Grant network roles to the `gcp-network-admins` group ✅
   * Grant security roles to the `gcp-security-admins` group ✅
   * Grant devops roles to the `gcp-devops` group ✅
1. Set folder-level policies ✅
   * Grant devops roles on the `Production` folder to the `gcp-devops` group ✅
   * Grant developer roles on the `Production` folder to the `gcp-developers` group ✅
1. Set project-level policies
   * Grant network roles on the `example-vpc-host-nonprod` and `example-vpc-host-prod` projects to the `gcp-network-admins` group ✅
   * Grant devops roles on the `example-monitoring-nonprod`, `example-monitoring-prod`, `example-logging-nonprod`, and `example-logging-prod` projects to the `gcp-devops` group ✅

### 7. Set up Support
1. Choose a support option

### 8. Set up networking configuration
1. Virtual private cloud architecture
1. Create the Shared VPC networks
   * Create the `Non-Production` VPC network ✅
   * Create the `Production` VPC network ✅
1. Configure connectivity between the external provider and GCP
1. Set up a path for external egress traffic
1. Implement network security controls
1. Choose an ingress traffic option

### 9. Set up logging and monitoring
1. Set up monitoring
1. Set up logging

### 10. Configure security settings for apps and data
1. Enable the Security Command Center dashboard
1. Set up Organization Policy

## Terraform Resources List

This is a list of resources created by this terraform config:

* `module.billing.data.google_billing_account.default`
* `module.logging-nonprod-project.google_project.project`
* `module.logging-nonprod-project.google_project_iam_member.project`
* `module.logging-prod-project.google_project.project`
* `module.logging-prod-project.google_project_iam_member.project`
* `module.monitoring-nonprod-project.google_project.project`
* `module.monitoring-nonprod-project.google_project_iam_member.project`
* `module.monitoring-prod-project.google_project.project`
* `module.monitoring-prod-project.google_project_iam_member.project`
* `module.org.data.google_iam_policy.non-production-folder`
* `module.org.data.google_iam_policy.org`
* `module.org.data.google_iam_policy.production-folder`
* `module.org.data.google_organization.org`
* `module.org.google_cloud_identity_group.groups["gcp-billing-admins"]`
* `module.org.google_cloud_identity_group.groups["gcp-developers"]`
* `module.org.google_cloud_identity_group.groups["gcp-devops"]`
* `module.org.google_cloud_identity_group.groups["gcp-network-admins"]`
* `module.org.google_cloud_identity_group.groups["gcp-organization-admins"]`
* `module.org.google_cloud_identity_group.groups["gcp-security-admins"]`
* `module.org.google_cloud_identity_group.groups["terraform-admins"]`
* `module.org.google_essential_contacts_contact.org`
* `module.org.google_folder.non-production`
* `module.org.google_folder.non-production-shared`
* `module.org.google_folder.production`
* `module.org.google_folder.production-shared`
* `module.org.google_folder_iam_policy.non-production`
* `module.org.google_folder_iam_policy.production`
* `module.org.google_organization_iam_policy.org`
* `module.org.google_organization_policy.compute_require_os_login`
* `module.org.google_organization_policy.compute_skip_default_network_creation`
* `module.terraform-project.data.google_iam_policy.admin-sa-user`
* `module.terraform-project.data.google_iam_policy.terraform-bucket`
* `module.terraform-project.google_iap_brand.project`
* `module.terraform-project.google_project.project`
* `module.terraform-project.google_project_iam_member.terraform["roles/owner"]`
* `module.terraform-project.google_project_iam_member.terraform["roles/storage.admin"]`
* `module.terraform-project.google_project_service.services["cloudbilling.googleapis.com"]`
* `module.terraform-project.google_project_service.services["cloudidentity.googleapis.com"]`
* `module.terraform-project.google_project_service.services["cloudresourcemanager.googleapis.com"]`
* `module.terraform-project.google_project_service.services["essentialcontacts.googleapis.com"]`
* `module.terraform-project.google_project_service.services["iam.googleapis.com"]`
* `module.terraform-project.google_project_service.services["iap.googleapis.com"]`
* `module.terraform-project.google_project_service.services["logging.googleapis.com"]`
* `module.terraform-project.google_project_service.services["secretmanager.googleapis.com"]`
* `module.terraform-project.google_project_service.services["serviceusage.googleapis.com"]`
* `module.terraform-project.google_project_service.services["storage-api.googleapis.com"]`
* `module.terraform-project.google_project_service.services["storage.googleapis.com"]`
* `module.terraform-project.google_secret_manager_secret.service-account-key`
* `module.terraform-project.google_secret_manager_secret_version.service-account-key`
* `module.terraform-project.google_service_account.terraform`
* `module.terraform-project.google_service_account_iam_policy.admin-account-iam`
* `module.terraform-project.google_service_account_key.terraform`
* `module.terraform-project.google_storage_bucket.terraform`
* `module.terraform-project.google_storage_bucket_iam_policy.terraform`
* `module.vpc-host-nonprod-project.data.google_project.vpc_service_projects["example-logging-nonprod"]`
* `module.vpc-host-nonprod-project.data.google_project.vpc_service_projects["example-monitoring-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_network.vpc`
* `module.vpc-host-nonprod-project.google_compute_shared_vpc_host_project.host`
* `module.vpc-host-nonprod-project.google_compute_shared_vpc_service_project.projects["example-logging-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_shared_vpc_service_project.projects["example-monitoring-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_subnetwork.east-private`
* `module.vpc-host-nonprod-project.google_compute_subnetwork.east-public`
* `module.vpc-host-nonprod-project.google_compute_subnetwork.west-private`
* `module.vpc-host-nonprod-project.google_compute_subnetwork.west-public`
* `module.vpc-host-nonprod-project.google_compute_subnetwork_iam_member.projects-east-private["example-logging-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_subnetwork_iam_member.projects-east-private["example-monitoring-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_subnetwork_iam_member.projects-east-public["example-logging-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_subnetwork_iam_member.projects-east-public["example-monitoring-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_subnetwork_iam_member.projects-west-private["example-logging-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_subnetwork_iam_member.projects-west-private["example-monitoring-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_subnetwork_iam_member.projects-west-public["example-logging-nonprod"]`
* `module.vpc-host-nonprod-project.google_compute_subnetwork_iam_member.projects-west-public["example-monitoring-nonprod"]`
* `module.vpc-host-nonprod-project.google_project.project`
* `module.vpc-host-nonprod-project.google_project_iam_member.project`
* `module.vpc-host-prod-project.data.google_project.vpc_service_projects["example-logging-prod"]`
* `module.vpc-host-prod-project.data.google_project.vpc_service_projects["example-monitoring-prod"]`
* `module.vpc-host-prod-project.google_compute_network.vpc`
* `module.vpc-host-prod-project.google_compute_shared_vpc_host_project.host`
* `module.vpc-host-prod-project.google_compute_shared_vpc_service_project.projects["example-logging-prod"]`
* `module.vpc-host-prod-project.google_compute_shared_vpc_service_project.projects["example-monitoring-prod"]`
* `module.vpc-host-prod-project.google_compute_subnetwork.east-private`
* `module.vpc-host-prod-project.google_compute_subnetwork.east-public`
* `module.vpc-host-prod-project.google_compute_subnetwork.west-private`
* `module.vpc-host-prod-project.google_compute_subnetwork.west-public`
* `module.vpc-host-prod-project.google_compute_subnetwork_iam_member.projects-east-private["example-logging-prod"]`
* `module.vpc-host-prod-project.google_compute_subnetwork_iam_member.projects-east-private["example-monitoring-prod"]`
* `module.vpc-host-prod-project.google_compute_subnetwork_iam_member.projects-east-public["example-logging-prod"]`
* `module.vpc-host-prod-project.google_compute_subnetwork_iam_member.projects-east-public["example-monitoring-prod"]`
* `module.vpc-host-prod-project.google_compute_subnetwork_iam_member.projects-west-private["example-logging-prod"]`
* `module.vpc-host-prod-project.google_compute_subnetwork_iam_member.projects-west-private["example-monitoring-prod"]`
* `module.vpc-host-prod-project.google_compute_subnetwork_iam_member.projects-west-public["example-logging-prod"]`
* `module.vpc-host-prod-project.google_compute_subnetwork_iam_member.projects-west-public["example-monitoring-prod"]`
* `module.vpc-host-prod-project.google_project.project`
* `module.vpc-host-prod-project.google_project_iam_member.project`
