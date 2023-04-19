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
  name     = "name-minimal0"
  location = "europe-west3"
  members = [
    "user:member@example.com",
  ]
  role   = "roles/viewer"
  source = "../.."
}
module "test1" {
  name          = "name-minimal1"
  authoritative = false
  location      = "europe-west3"
  members = [
    "user:member@example.com",
  ]
  role   = "roles/viewer"
  source = "../.."
}
module "test2" {
  name     = "name-minimal2"
  location = "europe-west3"
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
  role   = "roles/viewer"
  source = "../.."
}
