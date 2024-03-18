// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  required_version = "~> 1.0, != 1.1.0, != 1.1.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.48, < 6"
    }
  }
}
module "test0" {
  managed_zone = "managed_zone-disabled0"
  members = [
    "user:member@example.com",
  ]
  module_enabled = false
  project        = "my-project"
  role           = "roles/viewer"
  source         = "../.."
}
module "test1" {
  managed_zone  = "managed_zone-disabled1"
  authoritative = false
  members = [
    "user:member@example.com",
  ]
  module_enabled = false
  project        = "my-project"
  role           = "roles/viewer"
  source         = "../.."
}
module "test2" {
  managed_zone = "managed_zone-disabled2"
  members = [
    "user:member@example.com",
  ]
  module_enabled = false
  policy_bindings = [
    {
      role = "roles/viewer"
      members = [
        "user:member@example.com",
      ]
    },
  ]
  project = "my-project"
  role    = "roles/viewer"
  source  = "../.."
}
