generate_hcl "main.tf" {
  lets {
    provider = tm_basename(tm_dirname(terramate.stack.path.absolute))
  }

  content {
    tm_dynamic "resource" {
      labels = ["${terramate.stack.path.basename}_binding", "binding"]
      attributes = {
        global.resource_parent.variable = tm_hcl_expression("var.${global.resource_parent.variable}")
      }
      #condition = TODO: check if count can be replaced on this level

      content {
        count = var.module_enabled && var.policy_bindings == null && var.authoritative ? 1 : 0

        provider = tm_hcl_expression(let.provider)

        location = var.location

        role    = var.role
        members = [for m in var.members : try(var.computed_members_map[regex("^computed:(.*)", m)[0]], m)]

        depends_on = [var.module_depends_on]
      }
    }

    tm_dynamic "resource" {
      labels = ["${terramate.stack.path.basename}_member", "member"]
      attributes = {
        global.resource_parent.variable = tm_hcl_expression("var.${global.resource_parent.variable}")
      }

      content {
        for_each = var.module_enabled && var.policy_bindings == null && var.authoritative == false ? var.members : []

        provider = tm_hcl_expression(let.provider)

        location = var.location

        role   = var.role
        member = try(var.computed_members_map[regex("^computed:(.*)", each.value)[0]], each.value)

        depends_on = [var.module_depends_on]
      }
    }

    tm_dynamic "resource" {
      labels = ["${terramate.stack.path.basename}_policy", "policy"]
      attributes = {
        global.resource_parent.variable = tm_hcl_expression("var.${global.resource_parent.variable}")
      }

      content {
        count = var.module_enabled && var.policy_bindings != null ? 1 : 0

        provider = tm_hcl_expression(let.provider)

        location = var.location

        policy_data = try(data.google_iam_policy.policy[0].policy_data, null)

        depends_on = [var.module_depends_on]
      }
    }

    data "google_iam_policy" "policy" {
      count = var.module_enabled && var.policy_bindings != null ? 1 : 0

      provider = tm_hcl_expression(let.provider)

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
