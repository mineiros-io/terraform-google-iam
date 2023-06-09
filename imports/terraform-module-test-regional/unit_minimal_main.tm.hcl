generate_hcl "tests/unit-minimal/main.tf" {
  condition = tm_try(global.is_regional, false)

  lets {
    location = tm_try(global.region_attribute, "location")
  }

  content {
    terraform {
      required_version = global.terraform_version_constraint
      tm_dynamic "required_providers" {
        attributes = {
          tm_basename(tm_dirname(terramate.stack.path.absolute)) = {
            source  = "hashicorp/${tm_basename(tm_dirname(terramate.stack.path.absolute))}"
            version = global.minimum_provider_version
          }
        }
      }
    }

    tm_dynamic "module" {
      labels = ["test0"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-minimal0"
        let.location                    = "europe-west3"
      }

      content {
        source = "../.."

        # add all required arguments

        role = "roles/viewer"

        # add all optional arguments that create additional/extended resources

        project = "my-project"

        members = ["user:member@example.com"]

        # add most/all other optional arguments
      }
    }

    tm_dynamic "module" {
      labels = ["test1"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-minimal1"
        let.location                    = "europe-west3"
      }

      content {
        source = "../.."

        # add all required arguments

        role = "roles/viewer"

        # add all optional arguments that create additional/extended resources

        project = "my-project"

        authoritative = false
        members       = ["user:member@example.com"]

        # add most/all other optional arguments
      }
    }

    tm_dynamic "module" {
      labels = ["test2"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-minimal2"
        let.location                    = "europe-west3"
      }

      content {
        source = "../.."

        # add all required arguments

        role = "roles/viewer"

        # add all optional arguments that create additional/extended resources

        project = "my-project"

        members = ["user:member@example.com"]

        # add most/all other optional arguments

        policy_bindings = [
          {
            role    = "roles/viewer"
            members = ["user:member@example.com"]
          }
        ]
      }
    }
  }
}
