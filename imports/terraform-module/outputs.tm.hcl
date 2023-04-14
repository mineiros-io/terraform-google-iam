generate_hcl "outputs.tf" {
  content {
    locals {
      binding = tm_hcl_expression("one(${terramate.stack.path.basename}_binding.binding)")
      member  = tm_hcl_expression("${terramate.stack.path.basename}_member.member")
      policy  = tm_hcl_expression("one(${terramate.stack.path.basename}_policy.policy)")

      iam_output = [local.binding, local.member, local.policy]

      iam_output_index = var.policy_bindings != null ? 2 : var.authoritative ? 0 : 1
    }

    output "iam" {
      description = "All attributes of the created 'iam_binding' or 'iam_member' or 'iam_policy' resource according to the mode."
      value       = local.iam_output[local.iam_output_index]
    }
  }
}
