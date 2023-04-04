terramate {
  required_version                   = "~> 0.2.16"
  required_version_allow_prereleases = true

  config {
    run {
      env {
        TF_PLUGIN_CACHE_DIR    = "${terramate.root.path.fs.absolute}/.tf_plugin_cache_dir"
        TM_STACK_PATH_ABSOLUTE = terramate.stack.path.absolute
      }
    }
  }
}

import {
  source = "imports/main.tm.hcl"
}

import {
  source = "imports/variables.tm.hcl"
}

import {
  source = "imports/versions.tm.hcl"
}

import {
  source = "imports/outputs.tm.hcl"
}
