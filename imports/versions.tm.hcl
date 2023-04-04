generate_hcl "versions.tf" {
  content {
    terraform {
      required_version = global.versions.terraform

      required_providers {
        google = {
          source  = "hashicorp/${tm_basename(tm_dirname(terramate.stack.path.absolute))}"
          version = global.versions.google_provider
        }
      }
    }
  }
}
