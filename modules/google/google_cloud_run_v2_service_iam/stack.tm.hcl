stack {
  name        = "Google Cloud Run Service v2 IAM Module"
  description = "Cloud Run Service v2 IAM Terraform Module using Terraform Google Provider"
  id          = "d4ff08ba-bd59-4a25-8692-0c78e79fab0c"
}

globals {
  resource_parent = {
    variable    = "name"
    description = "Name of Cloud Run V2 service used to find the parent resource to bind the IAM policy to"
  }
  validation_member_regex = "allUsers|allAuthenticatedUsers|(user|serviceAccount|group|domain|projectOwner|projectEditor|projectViewer)"
}
