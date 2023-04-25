generate_hcl "variables.tf" {
  content {
    tm_dynamic "variable" {
      labels = [global.resource_parent.variable]
      content {
        description = "(Required) ${global.resource_parent.description}"
        type        = string
      }
    }

    variable "location" {
      description = "(Required) The location used to find the parent resource to bind the IAM policy to"
      type        = string
    }

    variable "project" {
      type        = string
      description = "The ID of the project in which the resource belongs. If it is not provided, the project will be parsed from the identifier of the parent resource. If no project is provided in the parent identifier and no project is specified, the provider project is used."
      default     = null
    }

    variable "members" {
      type        = set(string)
      description = "(Optional) Identities that will be granted the privilege in role."
      default     = []

      validation {
        condition     = tm_hcl_expression(let.m_condition)
        error_message = let.m_message
      }
    }

    variable "computed_members_map" {
      type        = map(string)
      description = "(Optional) A map of members to replace in 'var.members' or in members of 'policy_bindings' to handle terraform computed values."
      default     = {}

      validation {
        condition     = tm_hcl_expression(let.c_condition)
        error_message = let.c_message
      }
    }

    variable "role" {
      description = "(Optional) The IAM role to add the members to. Note that custom roles must be of the format '[projects|organizations]/{parent-name}/roles/{role-name}'."
      type        = string
      default     = null
    }

    variable "authoritative" {
      description = "(Optional) Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role."
      type        = bool
      default     = true
    }

    variable "policy_bindings" {
      description = "(Optional) A list of IAM policy bindings."
      type        = any
      default     = null
    }

    variable "module_enabled" {
      type        = bool
      description = "(Optional) Whether to create resources within the module or not."
      default     = true
    }

    variable "module_depends_on" {
      type        = any
      description = "(Optional) A list of external resources the module depends_on."
      default     = []
    }
  }

  lets {
    # We need to generate the used principals that this module supports in terms of regex, pattern and co

    m_regex = tm_join("|", [
      for p in tm_concat(global.supported_principals, ["computed"]) : global.available_principles[p].regex
    ])
    m_patterns = tm_join(", ", [
      for p in tm_concat(global.supported_principals, ["computed"]) : "`${global.available_principles[p].pattern}`"
    ])
    m_message   = "The value must be set of strings where each entry is a valid principal type identified with ${let.m_patterns}"
    m_condition = "alltrue([for m in var.members : can(regex(\"${let.m_regex}\", m))])"

    c_regex = tm_join("|", [
      for p in global.supported_principals : global.available_principles[p].regex
    ])
    c_patterns = tm_join(", ", [
      for p in global.supported_principals : "`${global.available_principles[p].pattern}`"
    ])
    c_message   = "The value must be set of strings where each entry is a valid principal type identified with ${let.c_patterns}"
    c_condition = "alltrue([for k, m in var.computed_members_map : can(regex(\"${let.c_regex}\", m))])"
  }
}
