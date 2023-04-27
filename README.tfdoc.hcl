header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/851a473f65dd7d857a9311ca255c6e2763c72afe/mineiros-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-google-iam"
  badge "build" {
    image = "https://github.com/mineiros-io/terraform-google-iam/workflows/Tests/badge.svg"
    text  = "Build Status"
    url   = "https://github.com/mineiros-io/terraform-google-iam/actions"
  }
  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam.svg?label=latest&sort=semver"
    text  = "GitHub tag (latest SemVer)"
    url   = "https://github.com/mineiros-io/terraform-google-iam/releases"
  }
  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    text  = "Terraform Version"
    url   = "https://github.com/hashicorp/terraform/releases"
  }
  badge "terraform-google-provider" {
    image = "https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform"
    text  = "Google Provider Version"
    url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
  }
  badge "discord" {
    image = "https://img.shields.io/badge/Discord-Terramate-7289d9.svg?logo=discord"
    text  = "Join Discord"
    url   = "https://terramate.io/discord"
  }
}

section {
  title = "Generic Google Cloud IAM Terramate Module"
  content = <<-EOT
    A [Terramate](https://www.terramate.io) module used to generate [Terraform](https://www.terraform.io) modules for Google Cloud IAM for different services on [Google Cloud Services (GCP)](https://cloud.google.com/).

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.
    EOT

  section {
    title = "Current List of Generated Modules"
    content = <<-EOT
      - [google_cloud_run_v2_job_iam](modules/google/google_cloud_run_v2_job_iam)
      - [google_cloud_run_v2_service_iam](modules/google/google_cloud_run_v2_service_iam)
    EOT
  }

  section {
    title = "Usage - How to Generate New IAM Modules"
    content = <<-EOT
      1. Create a new Terramate stack under `modules/{provider}`
      Example: `terramate create --no-generate modules/google/google_storage_bucket_iam`
      The stack folder name must match the Terraform resource name with the `_iam` suffix attached to it.
      2. Edit the file `stack.tm.hcl` to match the following template:
      ```hcl
      stack {
        name        = "google_storage_bucket_iam"
        description = "Google Storage Bucket IAM Terraform Module"
        id          = "randomly_generated_do_not_edit"
      }

      globals {
        resource_parent = {
          variable      = "bucket" # Refer to the terraform provider documentation to get this attribute
          resource_name = "google_storage_bucket"
          description   = "Name of Storage Bucket resource the IAM is applied to"
        }
        documentation = {
          service_name      = "Google Storage Bucket"
          google_docs_url   = "https://cloud.google.com/storage/docs/access-control/iam-roles"
          provider_docs_url = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam"
          example_role      = "storage.admin"
        }
      }
      ```
      3. Generate code:
        * `terramate fmt`
        * `terramate generate`
        * `make terradoc`
    EOT
  }
}
