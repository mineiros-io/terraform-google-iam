stack {
  name        = "google_cloud_run_v2_service_iam"
  description = "Google Cloud Run V2 Service IAM Terraform Module"
  id          = "d4ff08ba-bd59-4a25-8692-0c78e79fab0c"
}

globals {
  minimum_provider_version = "4.50"
  is_regional              = true
  resource_parent = {
    variable      = "name"
    resource_name = "google_cloud_run_v2_service"
    description   = "Name of Cloud Run V2 Service resource the IAM is applied to"
  }
  documentation = {
    service_name      = "Google Cloud Run V2 Service"
    google_docs_url   = "https://cloud.google.com/run/docs/reference/iam/roles"
    provider_docs_url = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service_iam"
    example_role      = "run.admin"
  }
}
