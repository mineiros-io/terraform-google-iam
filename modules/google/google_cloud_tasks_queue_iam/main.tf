// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "google_cloud_tasks_queue_iam_binding" "binding" {
  name     = var.name
  location = var.location
  count    = var.module_enabled && var.policy_bindings == null && var.authoritative ? 1 : 0
  depends_on = [
    var.module_depends_on,
  ]
  members  = [for m in var.members : try(var.computed_members_map[regex("^computed:(.*)", m)[0]], m)]
  project  = var.project
  provider = google
  role     = var.role
}
resource "google_cloud_tasks_queue_iam_member" "member" {
  name     = var.name
  location = var.location
  depends_on = [
    var.module_depends_on,
  ]
  for_each = var.module_enabled && var.policy_bindings == null && var.authoritative == false ? var.members : [
  ]
  member   = try(var.computed_members_map[regex("^computed:(.*)", each.value)[0]], each.value)
  project  = var.project
  provider = google
  role     = var.role
}
resource "google_cloud_tasks_queue_iam_policy" "policy" {
  name     = var.name
  location = var.location
  count    = var.module_enabled && var.policy_bindings != null ? 1 : 0
  depends_on = [
    var.module_depends_on,
  ]
  policy_data = try(data.google_iam_policy.policy[0].policy_data, null)
  project     = var.project
  provider    = google
}
data "google_iam_policy" "policy" {
  count    = var.module_enabled && var.policy_bindings != null ? 1 : 0
  provider = google
  dynamic "binding" {
    for_each = var.policy_bindings
    content {
      members = [for m in binding.value.members : try(var.computed_members_map[regex("^computed:(.*)", m)[0]], m)]
      role    = binding.value.role
      dynamic "condition" {
        for_each = try([
          binding.value.condition,
          ], [
        ])
        content {
          description = try(condition.value.description, null)
          expression  = condition.value.expression
          title       = condition.value.title
        }
      }
    }
  }
}
