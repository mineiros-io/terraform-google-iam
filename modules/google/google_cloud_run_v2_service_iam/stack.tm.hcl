stack {
  name        = "google_cloud_run_v2_service_iam"
  description = "Google Cloud Run V2 Service IAM Terraform Module"
  id          = "d4ff08ba-bd59-4a25-8692-0c78e79fab0c"
}

globals {
  resource_parent = {
    variable    = "name"
    description = "Name of Cloud Run V2 Service resource the IAM is applied to"
  }
}
