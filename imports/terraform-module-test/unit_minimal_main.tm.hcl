generate_hcl "tests/unit-minimal/_terramate_generated_main.tf" {
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
        global.resource_parent.identifier = "${global.resource_parent.identifier}-minimal0"
      }

      content {
        source = "../.."

        # add all required arguments

        role = "roles/viewer"

        # add all optional arguments that create additional/extended resources

        members = ["user:member@example.com"]

        # add most/all other optional arguments
      }
    }

    tm_dynamic "module" {
      labels = ["test1"]
      attributes = {
        global.resource_parent.identifier = "${global.resource_parent.identifier}-minimal1"
      }

      content {
        source = "../.."

        # add all required arguments

        role = "roles/viewer"

        # add all optional arguments that create additional/extended resources

        authoritative = false
        members       = ["user:member@example.com"]

        # add most/all other optional arguments
      }
    }

    tm_dynamic "module" {
      labels = ["test2"]
      attributes = {
        global.resource_parent.identifier = "${global.resource_parent.identifier}-minimal2"
      }

      content {
        source = "../.."

        # add all required arguments

        role = "roles/viewer"

        # add all optional arguments that create additional/extended resources

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
