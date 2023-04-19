generate_hcl "main.tf" {

  lets {
    attributes = { for k, v in global.variables : k => "var.${k}" }
  }

  content {
    tm_dynamic "resource" {
      labels = ["${terramate.stack.path.basename}_binding", "binding"]

      attributes = let.attributes

      content {
        count = var.module_enabled && var.policy_bindings == null && var.authoritative ? 1 : 0

        role    = var.role
        members = [for m in var.members : try(var.computed_members_map[regex("^computed:(.*)", m)[0]], m)]

        depends_on = [var.module_depends_on]
      }
    }

    tm_dynamic "resource" {
      labels = ["${terramate.stack.path.basename}_member", "member"]

      attributes = let.attributes

      content {
        for_each = var.module_enabled && var.policy_bindings == null && var.authoritative == false ? var.members : []

        role   = var.role
        member = try(var.computed_members_map[regex("^computed:(.*)", each.value)[0]], each.value)

        depends_on = [var.module_depends_on]
      }
    }

    tm_dynamic "resource" {
      labels = ["${terramate.stack.path.basename}_policy", "policy"]

      attributes = let.attributes

      content {
        count = var.module_enabled && var.policy_bindings != null ? 1 : 0

        policy_data = try(data.google_iam_policy.policy[0].policy_data, null)

        depends_on = [var.module_depends_on]
      }
    }

    data "google_iam_policy" "policy" {
      count = var.module_enabled && var.policy_bindings != null ? 1 : 0

      dynamic "binding" {
        for_each = var.policy_bindings

        content {
          role    = binding.value.role
          members = [for m in binding.value.members : try(var.computed_members_map[regex("^computed:(.*)", m)[0]], m)]

          dynamic "condition" {
            for_each = try([binding.value.condition], [])

            content {
              expression  = condition.value.expression
              title       = condition.value.title
              description = try(condition.value.description, null)
            }
          }
        }
      }
    }
  }
}
