generate_hcl "tests/unit-complete/main.tf" {
  content {
    terraform {
      required_version = global.terraform_version_constraint
      tm_dynamic "required_providers" {
        attributes = {
          tm_basename(tm_dirname(terramate.stack.path.absolute)) = {
            source  = "hashicorp/${tm_basename(tm_dirname(terramate.stack.path.absolute))}"
            version = global.provider_version_constraint
          }
        }
      }
    }

    module "test-sa" {
      source = "github.com/mineiros-io/terraform-google-service-account?ref=v0.1.1"

      account_id = "service-account-id-complete"
    }

    tm_dynamic "module" {
      labels = ["test0"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-complete0"
      }

      content {
        source = "../.."

        # add all required arguments

        role = "roles/viewer"

        location = "europe-west3"

        # add all optional arguments that create additional/extended resources

        members = [
          "user:member@example.com",
          "computed:myserviceaccount",
        ]
        computed_members_map = {
          myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
        }

        # condition = {
        #   title       = "allow after 2020"
        #   description = "allow access from 2020"
        #   expression  = "request.time.getFullYear() > 2020"
        # }
        # add most/all other optional arguments
      }
    }

    tm_dynamic "module" {
      labels = ["test1"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-complete1"
      }

      content {
        source = "../.."

        # add all required arguments

        role = "roles/viewer"

        location = "europe-west3"

        # add all optional arguments that create additional/extended resources

        authoritative = false
        members = [
          "user:member@example.com",
          "computed:myserviceaccount",
        ]
        computed_members_map = {
          myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
        }

        # add most/all other optional arguments
      }
    }

    tm_dynamic "module" {
      labels = ["test2"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-complete2"
      }

      content {
        source = "../.."

        # add all required arguments

        location = "europe-west3"

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
          }
        ]

        computed_members_map = {
          myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
        }
        # add all optional arguments that create additional/extended resources

        # add most/all other optional arguments
      }
    }

    tm_dynamic "module" {
      labels = ["test3"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-complete3"
      }

      content {
        source = "../.."

        # add all required arguments

        location = "europe-west3"

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

        computed_members_map = {
          myserviceaccount = "serviceAccount:${module.test-sa.service_account.email}"
        }
        # add all optional arguments that create additional/extended resources

        # add most/all other optional arguments
      }
    }
  }
}
