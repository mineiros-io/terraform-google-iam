stack {
  name        = "google_cloud_run_service_iam"
  description = "Google Cloud Run IAM Terraform Module"
  id          = "b9348cb3-744b-46e7-b731-969c5dc5f1a8"
}

globals {
  resource_parent = {
    variable      = "service"
    resource_name = "google_cloud_run_service"
    description   = "Name of Cloud Run resource the IAM is applied to"
  }
  documentation = {
    service_name      = "Google Cloud Run"
    google_docs_url   = "https://cloud.google.com/run/docs/reference/iam/roles"
    provider_docs_url = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam"
    example_role      = "run.invoker"
  }
}
