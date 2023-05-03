[<img src="https://raw.githubusercontent.com/mineiros-io/brand/851a473f65dd7d857a9311ca255c6e2763c72afe/mineiros-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-iam)

[![Build Status](https://github.com/mineiros-io/terraform-google-iam/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-iam/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-iam/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Discord](https://img.shields.io/badge/Discord-Terramate-7289d9.svg?logo=discord)](https://terramate.io/discord)

# Generic Google Cloud IAM Terramate Module

A [Terramate](https://www.terramate.io) module used to generate [Terraform](https://www.terraform.io) modules for Google Cloud IAM for different services on [Google Cloud Services (GCP)](https://cloud.google.com/).

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.

## Current List of Generated Modules

- [google_cloud_run_v2_job_iam](modules/google/google_cloud_run_v2_job_iam)
- [google_cloud_run_v2_service_iam](modules/google/google_cloud_run_v2_service_iam)
- [google_dns_managed_zone_iam](modules/google/google_dns_managed_zone_iam)
- [google_artifact_registry_repository_iam](modules/google/google_artifact_registry_repository_iam)
- [google_cloud_run_service_iam](modules/google/google_cloud_run_service_iam)

## Usage - How to Generate New IAM Modules

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
  * `pre-commit run -a` (this command may need to be run twice, validate once all output is green)

