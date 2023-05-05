stack {
  name        = "google_dns_managed_zone_iam"
  description = "Google Cloud DNS Managed Zone IAM Terraform Module"
  id          = "6a3b5ee3-498c-47da-a2a8-149875658bd9"
}

globals {
  minimum_provider_version = "4.48"
  resource_parent = {
    variable      = "managed_zone"
    resource_name = "google_dns_managed_zone"
    description   = "Name of Cloud DNS Managed Zone resource the IAM is applied to"
  }
  documentation = {
    service_name      = "Google Cloud DNS Managed Zone"
    google_docs_url   = "https://cloud.google.com/dns/docs/access-control"
    provider_docs_url = "https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone_iam"
    example_role      = "dns.admin"
  }
}
