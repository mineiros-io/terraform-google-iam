generate_hcl "versions.tf" {
  lets {
    provider = tm_basename(tm_dirname(terramate.stack.path.absolute))
  }

  content {
    terraform {
      required_version = global.terraform_version_constraint

      tm_dynamic "required_providers" {
        attributes = {
          let.provider = {
            source  = "hashicorp/${let.provider}"
            version = global.provider_version_constraint
          }
        }
      }
    }
  }
}
