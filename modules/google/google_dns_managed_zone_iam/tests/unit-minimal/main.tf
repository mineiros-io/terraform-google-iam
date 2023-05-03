// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  required_version = "~> 1.0, != 1.1.0, != 1.1.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50"
    }
  }
}
module "test0" {
  managed_zone = "managed_zone-minimal0"
  members = [
    "user:member@example.com",
  ]
  project = "my-project"
  role    = "roles/viewer"
  source  = "../.."
}
module "test1" {
  managed_zone  = "managed_zone-minimal1"
  authoritative = false
  members = [
    "user:member@example.com",
  ]
  project = "my-project"
  role    = "roles/viewer"
  source  = "../.."
}
module "test2" {
  managed_zone = "managed_zone-minimal2"
  members = [
    "user:member@example.com",
  ]
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
