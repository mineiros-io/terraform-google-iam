generate_hcl "variables.tf" {
  content {
    tm_dynamic "variable" {
      labels = [global.identifier.id]
      content {
        description = "(Required) ${global.identifier.description}"
        type        = string
      }
    }

    variable "members" {
      type        = set(string)
      description = "(Optional) Identities that will be granted the privilege in role. Each entry can have one of the following values: 'allUsers', 'allAuthenticatedUsers', 'user:{emailid}', 'serviceAccount:{emailid}', 'group:{emailid}', 'domain:{domain}'."
      default     = []

      validation {
        condition     = alltrue([for m in var.members : can(regex("^(${global.validation}|computed):)", m))])                                            #TODO: make it nicer with tm_()s
        error_message = "The value must be a non-empty list of strings where each entry is a valid principal type identified with ${global.validation}." #TODO: make it nicer with tm_()s
      }
    }

    variable "computed_members_map" {
      type        = map(string)
      description = "(Optional) A map of members to replace in 'var.members' or in members of 'policy_bindings' to handle terraform computed values."
      default     = {}

      validation {
        condition     = alltrue([for k, v in var.computed_members_map : can(regex("^(${global.validation}):)", v))])
        error_message = "The value must be a non-empty string being a valid principal type identified with ${global.validation}."
      }
    }

    variable "role" {
      description = "(Optional) The role that should be applied. Only one 'iam_binding' can be used per role. Note that custom roles must be of the format '[projects|organizations]/{parent-name}/roles/{role-name}'."
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
      description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
      default     = true
    }

    variable "module_depends_on" {
      type        = any
      description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
      default     = []
    }
  }
}
