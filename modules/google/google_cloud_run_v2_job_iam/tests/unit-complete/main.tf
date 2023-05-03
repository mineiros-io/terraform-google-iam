// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  required_version = "~> 1.0, != 1.1.0, != 1.1.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.50"
    }
  }
}
module "test-sa" {
  account_id = "service-account-id-complete"
  project    = "my-project"
  source     = "github.com/mineiros-io/terraform-google-service-account?ref=v0.1.1"
}
module "test0" {
  name     = "name-complete0"
  location = "europe-west3"
  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }
  members = [
    "user:member@example.com",
    "computed:myserviceaccount",
  ]
  project = "my-project"
  role    = "roles/viewer"
  source  = "../.."
}
module "test1" {
  name          = "name-complete1"
  location      = "europe-west3"
  authoritative = false
  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }
  members = [
    "user:member@example.com",
    "computed:myserviceaccount",
  ]
  project = "my-project"
  role    = "roles/viewer"
  source  = "../.."
}
module "test2" {
  name     = "name-complete2"
  location = "europe-west3"
  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }
  policy_bindings = [
    {
      role = "roles/viewer"
      members = [
        "user:member@example.com",
        "computed:myserviceaccount",
      ]
    },
    {
      role = "roles/browser"
      members = [
        "user:member@example.com",
      ]
    },
  ]
  project = "my-project"
  source  = "../.."
}
module "test3" {
  name     = "name-complete3"
  location = "europe-west3"
  computed_members_map = {
    myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
  }
  policy_bindings = [
    {
      role = "roles/viewer"
      members = [
        "user:member@example.com",
        "computed:myserviceaccount",
      ]
      condition = {
        expression = "request.time < timestamp(\"2022-01-01T00:00:00Z\")"
        title      = "expires_after_2021_12_31"
      }
    },
  ]
  project = "my-project"
  source  = "../.."
}
