stack {
  name        = "google_cloud_run_v2_service_iam"
  description = "Stack of IAM module for google_cloud_run_v2_service_iam resource"
  id          = "d4ff08ba-bd59-4a25-8692-0c78e79fab0c"
}


globals {
  resource_parent = {
    identifier  = "name"
    description = "Name of Cloud Run V2 service used to find the parent resource to bind the IAM policy to"
  }
  validation_member_regex = "allUsers|allAuthenticatedUsers|(user|serviceAccount|group|domain|principalSet|principal" #TODO: can be validation_regex
}
