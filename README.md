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
