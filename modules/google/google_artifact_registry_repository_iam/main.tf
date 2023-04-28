// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

resource "google_artifact_registry_repository_iam_binding" "binding" {
  repository = var.repository
  count      = var.module_enabled && var.policy_bindings == null && var.authoritative ? 1 : 0
  depends_on = [
    var.module_depends_on,
  ]
  location = var.location
  members  = [for m in var.members : try(var.computed_members_map[regex("^computed:(.*)", m)[0]], m)]
  project  = var.project
  provider = google
  role     = var.role
}
resource "google_artifact_registry_repository_iam_member" "member" {
  repository = var.repository
  depends_on = [
    var.module_depends_on,
  ]
  for_each = var.module_enabled && var.policy_bindings == null && var.authoritative == false ? var.members : [
  ]
  location = var.location
  member   = try(var.computed_members_map[regex("^computed:(.*)", each.value)[0]], each.value)
  project  = var.project
  provider = google
  role     = var.role
}
resource "google_artifact_registry_repository_iam_policy" "policy" {
  repository = var.repository
  count      = var.module_enabled && var.policy_bindings != null ? 1 : 0
  depends_on = [
    var.module_depends_on,
  ]
  location    = var.location
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
