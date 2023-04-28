// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  required_version = "~> 1.0, != 1.1.0, != 1.1.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.62"
    }
  }
}
module "test0" {
  repository = "repository-disabled0"
  location   = "europe-west3"
  members = [
    "user:member@example.com",
  ]
  module_enabled = false
  project        = "my-project"
  role           = "roles/viewer"
  source         = "../.."
}
module "test1" {
  repository    = "repository-disabled1"
  authoritative = false
  location      = "europe-west3"
  members = [
    "user:member@example.com",
  ]
  module_enabled = false
  project        = "my-project"
  role           = "roles/viewer"
  source         = "../.."
}
module "test2" {
  repository = "repository-disabled2"
  location   = "europe-west3"
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
