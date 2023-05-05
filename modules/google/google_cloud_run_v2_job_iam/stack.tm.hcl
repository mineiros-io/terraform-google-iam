stack {
  name        = "google_cloud_run_v2_job_iam"
  description = "Google Cloud Run V2 Job IAM Terraform Module"
  id          = "d7148f28-4e16-496c-9002-64da63c11361"
}

globals {
  minimum_provider_version = "4.50"
  is_regional              = true
  resource_parent = {
    variable      = "name"
    resource_name = "google_cloud_run_v2_job"
    description   = "Name of Cloud Run V2 Job resource the IAM is applied to"
  }
  documentation = {
    service_name      = "Google Cloud Run V2 Job"
    google_docs_url   = "https://cloud.google.com/run/docs/reference/iam/roles"
    provider_docs_url = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_job_iam"
    example_role      = "run.admin"
  }
}
