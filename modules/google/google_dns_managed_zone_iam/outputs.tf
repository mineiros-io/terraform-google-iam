// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

locals {
  binding = one(google_dns_managed_zone_iam_binding.binding)
  iam_output = [
    local.binding,
    local.member,
    local.policy,
  ]
  iam_output_index = var.policy_bindings != null ? 2 : var.authoritative ? 0 : 1
  member           = google_dns_managed_zone_iam_member.member
  policy           = one(google_dns_managed_zone_iam_policy.policy)
}
output "iam" {
  description = "All attributes of the created 'iam_binding' or 'iam_member' or 'iam_policy' resource according to the mode."
  value       = local.iam_output[local.iam_output_index]
}
