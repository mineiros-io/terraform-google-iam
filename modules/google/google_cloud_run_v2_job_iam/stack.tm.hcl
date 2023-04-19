stack {
  name        = "google_cloud_run_v2_job_iam"
  description = "google_cloud_run_v2_job_iam"
  id          = "d7148f28-4e16-496c-9002-64da63c11361"
}

globals {
  resource_parent = {
    variable    = "name"
    description = "Name of Cloud Run V2 job used to find the parent resource to bind the IAM policy to"
  }
  validation_member_regex = "allUsers|allAuthenticatedUsers|(user|serviceAccount|group|domain|projectOwner|projectEditor|projectViewer)"
}
