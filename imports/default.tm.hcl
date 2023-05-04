# terraform module files
import {
  source = "terraform-module/main-regional.tm.hcl"
}

import {
  source = "terraform-module/main-global.tm.hcl"
}

import {
  source = "terraform-module/variables.tm.hcl"
}

import {
  source = "terraform-module/versions.tm.hcl"
}

import {
  source = "terraform-module/outputs.tm.hcl"
}

import {
  source = "terraform-module/README.tm.hcl"
}

import {
  source = "terraform-module/principals.tm.hcl"
}

#tests

import {
  source = "terraform-module-test-regional/unit_complete_main.tm.hcl"
}

import {
  source = "terraform-module-test-regional/unit_minimal_main.tm.hcl"
}

import {
  source = "terraform-module-test-regional/unit_disabled_main.tm.hcl"
}

import {
  source = "terraform-module-test-global/unit_complete_main.tm.hcl"
}

import {
  source = "terraform-module-test-global/unit_minimal_main.tm.hcl"
}

import {
  source = "terraform-module-test-global/unit_disabled_main.tm.hcl"
}
