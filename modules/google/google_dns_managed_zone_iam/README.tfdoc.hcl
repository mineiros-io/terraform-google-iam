// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/851a473f65dd7d857a9311ca255c6e2763c72afe/mineiros-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-google-iam"
  badge "build" {
    image = "https://github.com/mineiros-io/terraform-google-iam/workflows/Tests/badge.svg"
    text  = "Build Status"
    url   = "https://github.com/mineiros-io/terraform-google-iam/actions"
  }
  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam.svg?label=latest&sort=semver"
    text  = "GitHub tag (latest SemVer)"
    url   = "https://github.com/mineiros-io/terraform-google-iam/releases"
  }
  badge "terraform" {
    image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
    text  = "Terraform Version"
    url   = "https://github.com/hashicorp/terraform/releases"
  }
  badge "terraform-google-provider" {
    image = "https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform"
    text  = "Google Provider Version"
    url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
  }
  badge "discord" {
    image = "https://img.shields.io/badge/Discord-Terramate-7289d9.svg?logo=discord"
    text  = "Join Discord"
    url   = "https://terramate.io/discord"
  }
}
section {
  content = <<-EOT
A [Terraform](https://www.terraform.io) module to create a [Google Cloud DNS Managed Zone IAM](https://cloud.google.com/dns/docs/access-control) on [Google Cloud Services (GCP)](https://cloud.google.com/).

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 4._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.
EOT

  title = "Google Cloud DNS Managed Zone IAM Terraform Module"
  toc   = true
  section {
    content = <<-EOT
This module implements the following Terraform resources:

- `google_dns_managed_zone_iam_binding`
- `google_dns_managed_zone_iam_member`
- `google_dns_managed_zone_iam_policy`
EOT

    title = "Module Features"
  }
  section {
    content = <<-EOT
Most common usage of the module:

```hcl
module "google_dns_managed_zone_iam" {
  source = "github.com/mineiros-io/terraform-google-iam//modules/google/google_dns_managed_zone_iam?ref=v0.1.1"

  managed_zone  = google_dns_managed_zone.default.name
  location = google_dns_managed_zone.default.location
  role     = "roles/dns.admin"
  members  = ["user:admin@example.com"]
}
```
EOT

    title = "Getting Started"
  }
  section {
    content = <<-EOT
See [variables.tf] for details.
EOT

    title = "Module Argument Reference"
    section {
      title = "Top-level Arguments"
      section {
        title = "Main Resource Configuration"
        variable "managed_zone" {
          description = <<-EOT
Name of Cloud DNS Managed Zone resource the IAM is applied to.
EOT

          required = true
          type     = string
        }
        variable "location" {
          description = <<-EOT
The location used to find the parent resource to bind the IAM policy to.
EOT

          required = true
          type     = string
        }
        variable "members" {
          default = [
          ]
          description = <<-EOT
Identities that will be granted the privilege in role. Each entry can have one of the following values:
`allUsers`, `allAuthenticatedUsers`, `user:{emailid}`, `serviceAccount:{emailid}`, `group:{emailid}`, `domain:{domain}`, `projectOwner:{projectid}`, `projectEditor:{projectid}`, `projectViewer:{projectid}`, `computed:{identifier}`.
EOT

          type = set(string)
        }
        variable "computed_members_map" {
          default     = {}
          description = <<-EOT
A map of members to replace in 'var.members' or in members of 'policy_bindings' to handle terraform computed values.
EOT

          type = map(string)
        }
        variable "role" {
          description = <<-EOT
The role that should be applied. Note that custom roles must be of the format `[projects|organizations]/{parent-name}/roles/{role-name}`. Omit if `policy_bindings` is set.
EOT

          type = string
        }
        variable "project" {
          description = <<-EOT
The ID of the project in which the resource belongs. If it is not provided, the project will be parsed from the identifier of the parent resource. If no project is provided in the parent identifier and no project is specified, the provider project is used.
EOT

          type = string
        }
        variable "authoritative" {
          default     = true
          description = <<-EOT
Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.
EOT

          type = bool
        }
        variable "policy_bindings" {
          description = <<-EOT
A list of IAM policy bindings. Cannot be used at the same time as `role`.
EOT

          readme_example = <<-EOT
policy_bindings = [{
  role    = "roles/dns.admin"
  members = ["user:admin@example.com"]
}]
EOT

          type = list(policy_binding)
          attribute "role" {
            description = <<-EOT
The role that should be applied.
EOT

            required = true
            type     = string
          }
          attribute "members" {
            default     = var.members
            description = <<-EOT
Identities that will be granted the privilege in `role`.
EOT

            type = set(string)
          }
          attribute "condition" {
            description = <<-EOT
An IAM Condition for a given binding.
EOT

            readme_example = <<-EOT
condition = {
  expression = "request.time < timestamp(\"2024-01-01T00:00:00Z\")"
  title      = "expires_after_2023_12_31"
}
EOT

            type = object(condition)
            attribute "expression" {
              description = <<-EOT
Textual representation of an expression in Common Expression Language syntax.
EOT

              required = true
              type     = string
            }
            attribute "title" {
              description = <<-EOT
A title for the expression, i.e. a short string describing its purpose.
EOT

              required = true
              type     = string
            }
            attribute "description" {
              description = <<-EOT
An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.
EOT

              type = string
            }
          }
        }
      }
      section {
        title = "Module Configuration"
        variable "module_enabled" {
          default     = true
          description = <<-EOT
Specifies whether resources in the module will be created.
EOT

          type = bool
        }
        variable "module_depends_on" {
          description = <<-EOT
A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
EOT

          readme_example = <<-EOT
module_depends_on = [
  google_network.network
]
EOT

          type = list(dependency)
        }
      }
    }
  }
  section {
    content = <<-EOT
The following attributes are exported in the outputs of the module:
EOT

    title = "Module Outputs"
    output "iam" {
      description = <<-EOT
All attributes of the created `google_dns_managed_zone_iam_binding` or `google_dns_managed_zone_iam_member` or `google_dns_managed_zone_iam_policy` resource according to the mode.
EOT

      type = object(iam)
    }
  }
  section {
    title = "External Documentation"
    section {
      content = <<-EOT
- https://cloud.google.com/dns/docs/access-control
EOT

      title = "Google Documentation"
    }
    section {
      content = <<-EOT
- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone_iam
EOT

      title = "Terraform Google Provider Documentation:"
    }
  }
  section {
    content = <<-EOT
This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.
EOT

    title = "Module Versioning"
    section {
      content = <<-EOT
- Backward compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backward compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
EOT

      title = "Backward compatibility in `0.0.z` and `0.y.z` version"
    }
  }
  section {
    content = <<-EOT
[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Discord server][discord].
EOT

    title = "About Mineiros"
  }
  section {
    content = <<-EOT
We use GitHub [Issues] to track community reported issues and missing features.
EOT

    title = "Reporting Issues"
  }
  section {
    content = <<-EOT
Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
EOT

    title = "Contributing"
  }
  section {
    content = <<-EOT
This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.
EOT

    title = "Makefile Targets"
  }
  section {
    content = <<-EOT
[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2023 [Mineiros GmbH][homepage]
EOT

    title = "License"
  }
}
references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-google-iam"
  }
  ref "hello@mineiros.io" {
    value = "mailto:hello@mineiros.io"
  }
  ref "badge-build" {
    value = "https://github.com/mineiros-io/terraform-google-iam/workflows/Tests/badge.svg"
  }
  ref "badge-semver" {
    value = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam.svg?label=latest&sort=semver"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "badge-terraform" {
    value = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
  }
  ref "badge-slack" {
    value = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
  }
  ref "build-status" {
    value = "https://github.com/mineiros-io/terraform-google-iam/actions"
  }
  ref "releases-github" {
    value = "https://github.com/mineiros-io/terraform-google-iam/releases"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "badge-tf-gcp" {
    value = "https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform"
  }
  ref "releases-google-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-google/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "discord" {
    value = "https://terramate.io/discord"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "gcp" {
    value = "https://cloud.google.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-google-iam/blob/main/modules/google/google_dns_managed_zone_iam/variables.tf"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-google-iam/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-google-iam/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-google-iam/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-google-iam/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-google-iam/blob/main/CONTRIBUTING.md"
  }
}
