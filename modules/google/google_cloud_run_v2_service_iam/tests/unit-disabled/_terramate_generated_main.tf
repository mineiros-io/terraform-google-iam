// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  required_version = "~> 1.0, != 1.1.0, != 1.1.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
module "test0" {
  name = "name-disabled0"
  members = [
    "user:member@example.com",
  ]
  module_enabled = false
  role           = "roles/viewer"
  source         = "../.."
}
module "test1" {
  name          = "name-disabled1"
  authoritative = false
  members = [
    "user:member@example.com",
  ]
  module_enabled = false
  role           = "roles/viewer"
  source         = "../.."
}
module "test2" {
  name = "name-disabled2"
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
  role   = "roles/viewer"
  source = "../.."
}
