stack {
  name        = "google_cloud_tasks_queue_iam"
  description = "Google Cloud Tasks IAM Terraform Module"
  id          = "782050be-255c-4aa6-9144-57a003cc4846"
}

globals {
  minimum_provider_version = "4.28"
  is_regional              = true
  resource_parent = {
    variable      = "name"
    resource_name = "google_cloud_tasks_queue"
    description   = "Name of Cloud Tasks Queue the IAM is applied to"
  }
  documentation = {
    service_name      = "Google Cloud Tasks"
    google_docs_url   = "https://cloud.google.com/tasks/docs/reference-access-control"
    provider_docs_url = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_tasks_queue_iam"
    example_role      = "cloudtasks.taskRunner"
  }
}
