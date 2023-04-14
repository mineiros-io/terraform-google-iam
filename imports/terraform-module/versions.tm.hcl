generate_hcl "versions.tf" {
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
  }
}
