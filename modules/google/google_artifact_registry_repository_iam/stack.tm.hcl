stack {
  name        = "google_artifact_registry_repository_iam"
  description = "Google Artifact Registry Repository IAM Terraform Module"
  id          = "7d6dedfa-eecc-48d7-abed-5052c3452802"
}

globals {
  resource_parent = {
    variable      = "repository"
    resource_name = "google_artifact_registry_repository"
    description   = "Name of Artifact Registry Repository resource the IAM is applied to"
  }
  documentation = {
    service_name      = "Google Artifact Registry Repository"
    google_docs_url   = "https://cloud.google.com/artifact-registry/docs/access-control"
    provider_docs_url = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam"
    example_role      = "artifactregistry.reader"
  }
}
