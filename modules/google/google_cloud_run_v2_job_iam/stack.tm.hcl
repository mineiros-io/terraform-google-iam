stack {
  name        = "google_cloud_run_v2_job_iam"
  description = "Google Cloud Run V2 Job IAM Terraform Module"
  id          = "d7148f28-4e16-496c-9002-64da63c11361"
}

globals {
  resource_parent = {
    variable    = "name"
    description = "Name of Cloud Run V2 Job resource the IAM is applied to"
  }
}
