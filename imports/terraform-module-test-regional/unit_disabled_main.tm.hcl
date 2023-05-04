generate_hcl "tests/unit-disabled/main.tf" {
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
            version = global.provider_version_constraint
          }
        }
      }
    }

    tm_dynamic "module" {
      labels = ["test0"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-disabled0"
        let.location                    = "europe-west3"
      }

      content {
        source = "../.."

        # add all required arguments

        project = "my-project"

        role = "roles/viewer"

        # add all optional arguments that create additional/extended resources

        members = ["user:member@example.com"]

        # add most/all other optional arguments

        module_enabled = false
      }
    }

    tm_dynamic "module" {
      labels = ["test1"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-disabled1"
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

        module_enabled = false
      }
    }

    tm_dynamic "module" {
      labels = ["test2"]
      attributes = {
        global.resource_parent.variable = "${global.resource_parent.variable}-disabled2"
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

        module_enabled = false
      }
    }
  }
}
