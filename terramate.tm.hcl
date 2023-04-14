terramate {
  required_version                   = "~> 0.2.16"
  required_version_allow_prereleases = true

  config {
    run {
      env {
        TF_PLUGIN_CACHE_DIR = "${terramate.root.path.fs.absolute}/.tf_plugin_cache_dir"
      }
    }
  }
}


# terraform module files
import {
  source = "imports/terraform-module/main.tm.hcl"
}

import {
  source = "imports/terraform-module/variables.tm.hcl"
}

import {
  source = "imports/terraform-module/versions.tm.hcl"
}

import {
  source = "imports/terraform-module/outputs.tm.hcl"
}

import {
  source = "imports/terraform-module/README.tm.hcl"
}

#tests

import {
  source = "imports/terraform-module-test/unit_complete_main.tm.hcl"
}

import {
  source = "imports/terraform-module-test/unit_minimal_main.tm.hcl"
}

import {
  source = "imports/terraform-module-test/unit_disabled_main.tm.hcl"
}

globals {
  minimum_terraform_version = "1.0"
  minimum_provider_version  = "4.0"

  provider_version_constraint  = "~> ${global.minimum_provider_version}"
  terraform_version_constraint = "~> ${global.minimum_terraform_version}, != 1.1.0, != 1.1.1"
  # we exclude 1.1.0 and 1.1.1 because of:
  # https://github.com/hashicorp/terraform/blob/v1.1/CHANGELOG.md#112-december-17-2021
}
