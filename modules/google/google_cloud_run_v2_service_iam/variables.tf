// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

variable "name" {
  description = "(Required) Used to find the parent resource to bind the IAM policy to"
  type        = string
}
variable "members" {
  default = [
  ]
  description = "(Optional) Identities that will be granted the privilege in role. Each entry can have one of the following values: 'allUsers', 'allAuthenticatedUsers', 'user:{emailid}', 'serviceAccount:{emailid}', 'group:{emailid}', 'domain:{domain}'."
  type        = set(string)
  validation {
    condition     = alltrue([for m in var.members : can(regex("^(${global.validation}|computed):)", m))])
    error_message = "The value must be a non-empty list of strings where each entry is a valid principal type identified with allUsers|allAuthenticatedUsers|(user|serviceAccount|group|domain|principalSet|principal."
  }
}
variable "computed_members_map" {
  default     = {}
  description = "(Optional) A map of members to replace in 'var.members' or in members of 'policy_bindings' to handle terraform computed values."
  type        = map(string)
  validation {
    condition     = alltrue([for k, v in var.computed_members_map : can(regex("^(${global.validation}):)", v))])
    error_message = "The value must be a non-empty string being a valid principal type identified with allUsers|allAuthenticatedUsers|(user|serviceAccount|group|domain|principalSet|principal."
  }
}
variable "role" {
  default     = null
  description = "(Optional) The role that should be applied. Only one 'iam_binding' can be used per role. Note that custom roles must be of the format '[projects|organizations]/{parent-name}/roles/{role-name}'."
  type        = string
}
variable "authoritative" {
  default     = true
  description = "(Optional) Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role."
  type        = bool
}
variable "policy_bindings" {
  default     = null
  description = "(Optional) A list of IAM policy bindings."
  type        = any
}
variable "module_enabled" {
  default     = true
  description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
  type        = bool
}
variable "module_depends_on" {
  default = [
  ]
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  type        = any
}
