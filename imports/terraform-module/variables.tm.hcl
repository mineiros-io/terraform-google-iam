generate_hcl "variables.tf" {
  content {
    tm_dynamic "variable" {
      labels = [global.resource_parent.variable]
      content {
        description = "(Required) ${global.resource_parent.description}"
        type        = string
      }
    }

    variable "members" {
      type        = set(string)
      description = "(Optional) Identities that will be granted the privilege in role." #Each entry can have one of the following values: ${tm_join(", ", [for i in tm_split(",", tm_replace(tm_replace(global.validation_member_regex, "/\\(|\\)/", ""), "|", ",")) : tm_can(tm_regex("all", i)) ? "`${i}`" : "`${i}:{variable_id}`"])} or `computed:{variable_id}`." #TODO: make more detailed (emailid,domain,whatever)
      default     = []

      validation {
        condition     = tm_hcl_expression("alltrue([for m in var.members : can(regex(\"^(${tm_trimsuffix(global.validation_member_regex, ")")}|computed):)\", m))])")
        error_message = "The value must be a non-empty list of strings where each entry is a valid principal type identified with ${tm_join(", ", [for i in tm_split(",", tm_replace(tm_replace(global.validation_member_regex, "/\\(|\\)/", ""), "|", ",")) : tm_can(tm_regex("all", i)) ? "`${i}`" : "`${i}:`"])} or `computed:`."
      }
    }

    variable "computed_members_map" {
      type        = map(string)
      description = "(Optional) A map of members to replace in 'var.members' or in members of 'policy_bindings' to handle terraform computed values."
      default     = {}

      validation {
        condition     = tm_hcl_expression("alltrue([for k, v in var.computed_members_map : can(regex(\"^(${global.validation_member_regex}:)\", v))])")
        error_message = "The value must be a non-empty string being a valid principal type identified with ${tm_join(", ", [for i in tm_split(",", tm_replace(tm_replace(global.validation_member_regex, "/\\(|\\)/", ""), "|", ",")) : tm_can(tm_regex("all", i)) ? "`${i}`" : "`${i}:`"])}."
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
}
