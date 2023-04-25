terramate {
  required_version                   = "~> 0.2.16"
  required_version_allow_prereleases = true

  config {
    run {
      env {
        TF_PLUGIN_CACHE_DIR = "${terramate.root.path.fs.absolute}/.tf_plugin_cache_dir"
        TM_STACK_PATH       = terramate.stack.path.relative
        TM_STACK_TO_ROOT    = terramate.stack.path.to_root
      }
    }
  }
}

globals {
  minimum_terraform_version = "1.0"
  minimum_provider_version  = "4.62"

  provider_version_constraint  = "~> ${global.minimum_provider_version}"
  terraform_version_constraint = "~> ${global.minimum_terraform_version}, != 1.1.0, != 1.1.1"
  # we exclude 1.1.0 and 1.1.1 because of:
  # https://github.com/hashicorp/terraform/blob/v1.1/CHANGELOG.md#112-december-17-2021
}

import {
  source = "imports/default.tm.hcl"
}
