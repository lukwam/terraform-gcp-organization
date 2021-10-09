# How to Use this Terraform Config

This Terraform config is designed to be used on a brand new GCP Organization.

## First Time Users

If you are using this Terraform config for the first time, it is **highly recommended** that you start with a **test domain** where you can plan and apply the config before you create your **production domain**.

For example, if your domain is `example.com`, you can start by setting up a new GCP Organization for `test.example.com`.

Going forward, this test domain will provide you with a way to test any changes you will make to your Terraform config before you apply them to production

## Creating a New GCP Organization

To use this Terraform config, you have to start with a brand new GCP Organization. If you have already gone through the steps to set up a new [Cloud Identity](https://cloud.google.com/identity/docs/setup) or [Google Workspace](https://workspace.google.com/) domain, then you can skip this section.

To set up a new **Cloud Identity** Organization, follow these steps:

1. Open a new Chrome Profile or Incognito Window. This is highly recommended because we will create a new domain and a new superadmin user account and then we will do all the other steps as that user.
1. Go to https://workspace.google.com/signup/gcpidentity/welcome#0 to sign up for **Cloud Identity**. Click `NEXT` to continue.
1. On the "Tell us about your business" page, enter your domain name (ex. `test.example.com`) as the Business name. You can always change this later. Select an option for "Number of employees, including you" (ex. "Just you"). Click `NEXT` to continue.
1. On the "Where is your business located?" page, select your country (ex. "United States"). Click `NEXT` to continue.
1. On the "What's your current email address?" page, enter an email address that you use regularly (ex. `first.last@gmail.com`). Click `NEXT` to continue.
1. On the "What's your business's domain name?" page, enter your domain name (ex. `test.example.com`).
1. On the "Use this domain to set up the account?" page, confirm your domain name and click `NEXT` continue.
1. On the "What's your name?" page enter your First and Last name and click `NEXT` to continue.
1. On the "How you'll sign in" page, enter a username (ex. `admin`) and a password that will be used for your superadmin account. Click `NEXT` to continue.
1. On the "Educate your users" page, click `NO THANKS`.
1. On the "You're almost done creating your Cloud Identity account" page, verify that you are not a robot.
1. Review to the [Cloud Identity Agreement](https://admin.google.com/terms/cloud_identity/1/2/en/na_terms.html) and click `AGREE AND CREATE ACCOUNT` to continue.
1. On the "Your Cloud Identity account has been created" page, click `GO TO SETUP` to continue.
1. Login with your new account (ex. `admin@test.example.com`)
1. Verify your Phone Number if requested.
1. On the "Welcome, let's set up Cloud Identity" page, Click `VERIFY` to verify your domain name by adding a TXT record to your DNS settings.
1. Complete the domain verification steps and then click `VERIFY MY DOMAIN`.
1. Create users (you can skip this step if you are the only user).
1. Click [Set up GCP Cloud Console now](https://console.cloud.google.com/iam-admin/cloudidentity?authuser=0).
1. Click [GO TO THE CHECKLIST](https://console.cloud.google.com/cloud-setup/overview?authuser=0).

Now you are ready to start working with the Terraform config.

## Clone the Repo

In this section, we will clone the repo from GitHub.

1. Open a Chrome Profile that is logged into your new account (ex. `admin@test.example.com`).
1. Open a Cloud Shell: https://console.cloud.google.com/getting-started?cloudshell=true.
1. Click `Open Editor` to open the Cloud Shell Editor.
1. Go to the `Terminal` menu and click `New Terminal`.
1. Create an SSH key in your new Cloud Shell: `ssh-keygen -t ecdsa`
1. Get the contents of the new public key: `cat ~/.ssh/id_ecdsa.pub`
1. Add the public key into your GitHub SSH keys: https://github.com/settings/keys
1. Clone the repo in the Cloud Shell Terminal: `git clone git@github.com:lukwam/terraform-gcp-organization`

## Configure Terraform

In this section, we will configure the `terraform.tfvars` file for your environment.

1. Change into the terraform directory: `cd terraform-gcp-organization/terraform`
1. Copy the example tfvars file: `cp terraform.tfvars.example terraform.tfvars`
1. Open the tfvars file in the Cloud Shell Editor: `edit terraform.tfvars`
1. Enter the display name of your Billing Account.
1. Enter the name of the superadmin user you created earlier (and with which you are currently logged in) (ex. `admin`).
1. Enter the domain name you used when you set up Cloud Identity (ex. `test.example.com`)
1. Enter an email address to set as the Organization Contact. Use the same email you used during the Cloud Identity setup (ex. `first.last@gmail.com`).
1. Set the project prefix that will be used for all of your GCP projects (ex. `exampletest`).

## Set Initial IAM Policy Bindings

Before you can run this config, you need to set some initial IAM policy bindings so you have enough permissions to apply the config to your new GCP Organization.

1. Add the new admin account as a `Billing Account Administrator` to your Billing Account: https://console.cloud.google.com/billing (ex. `admin@test.example.com`)
1. Add additional Roles for your superadmin user (ex. `admin@test.example.com`)) at the Organization Level. Go to: https://console.cloud.google.com/iam-admin/iam and select your new GCP Organization.
   * Add `Essential Contacts Admin` - so you can add Essential Contacts
   * Add `Folder Admin` - so that you can create folders
   * Add `Service Acccount Key Admin` - So that you can create a service account key
1. Make sure that your Billing Account has sufficient quota to create at least `7` (seven) new GCP projects. More information about Billing Accounts and Project quotas is available here: https://support.google.com/cloud/answer/6330231?hl=en

## Apply the Terraform Config

1. Initialize Terraform: `terraform init`
1. To get started, run a targeted apply to verify the Biling Account permissions are set properly: `terraform apply -target module.billing`
1. Verify that the correct Billing Account is displayed as `billing_account_name` and then type `yes` and return to apply.
1. To create the project that we will use for the Terraform service account and state bucket, run another targeted apply: `terraform apply -target module.terraform-project`
1. Verify the resources that Terraform plans to create, including an Org Folder called `Production` and a project called `exampletest-terraform`, and then type `yes` and return to apply.
1. To create the Cloud Identity Groups that will be used to manage the Organization level permissions, run another targeted apply: `terraform apply -target module.org.google_cloud_identity_group.groups`
1. Verify the resources that Terraform plans to create and then type `yes` and return to apply.
1. Now, we can apply the rest of the Terraform config to create the other Org Level resources and the Logging and Monitoring projects.










