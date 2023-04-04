globals {
  identifier = {
    id          = "name"
    description = "Used to find the parent resource to bind the IAM policy to"
  }
  validation = "allUsers|allAuthenticatedUsers|(user|serviceAccount|group|domain|principalSet|principal" #TODO: can be validation_regex

  versions = {
    terraform       = "~> 1.0"
    google_provider = "~> 4.0"
  }
}
