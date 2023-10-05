generate_hcl "README.tfdoc.hcl" {
  lets {
    provider = tm_basename(tm_dirname(terramate.stack.path.absolute))

    location = tm_try(global.region_attribute, "location")

    members_patterns = tm_join(", ", [
      for p in tm_concat(global.supported_principals, ["computed"]) : "`${global.available_principles[p].pattern}`"
    ])
  }

  content {
    header {
      image = "https://raw.githubusercontent.com/mineiros-io/brand/851a473f65dd7d857a9311ca255c6e2763c72afe/mineiros-logo.svg"
      url   = "https://mineiros.io/?ref=terraform-google-iam"

      badge "build" {
        image = "https://github.com/mineiros-io/terraform-google-iam/workflows/Tests/badge.svg"
        url   = "https://github.com/mineiros-io/terraform-google-iam/actions"
        text  = "Build Status"
      }

      badge "semver" {
        image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam.svg?label=latest&sort=semver"
        url   = "https://github.com/mineiros-io/terraform-google-iam/releases"
        text  = "GitHub tag (latest SemVer)"
      }

      badge "terraform" {
        image = "https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform"
        url   = "https://github.com/hashicorp/terraform/releases"
        text  = "Terraform Version"
      }

      badge "terraform-google-provider" {
        image = "https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform"
        url   = "https://github.com/terraform-providers/terraform-provider-google/releases"
        text  = "Google Provider Version"
      }

      badge "discord" {
        image = "https://img.shields.io/badge/Discord-Terramate-7289d9.svg?logo=discord"
        url   = "https://terramate.io/discord"
        text  = "Join Discord"
      }
    }

    section {
      title   = "${terramate.stack.description}"
      toc     = true
      content = <<-END
        A [Terraform](https://www.terraform.io) module to create a [${global.documentation.service_name} IAM](${global.documentation.google_docs_url}) on [Google Cloud Services (GCP)](https://cloud.google.com/).

        **_This module supports Terraform version 1
        and is compatible with the Terraform Google Provider version 4._**

        This module is part of our Infrastructure as Code (IaC) framework
        that enables our users and customers to easily deploy and manage reusable,
        secure, and production-grade cloud infrastructure.
      END

      section {
        title   = "Module Features"
        content = <<-END
          This module implements the following Terraform resources:

          - `${terramate.stack.path.basename}_binding`
          - `${terramate.stack.path.basename}_member`
          - `${terramate.stack.path.basename}_policy`
        END
      }

      tm_dynamic "section" {
        condition = tm_try(global.is_regional, false)
        content {
          title   = "Getting Started"
          content = <<-END
            Most common usage of the module:

            ```hcl
            module "${terramate.stack.path.basename}" {
              source = "github.com/mineiros-io/terraform-google-iam//modules/${let.provider}/${terramate.stack.path.basename}?ref=v0.1.3"

              ${global.resource_parent.variable}  = ${global.resource_parent.resource_name}.default.name
              ${let.location} = ${global.resource_parent.resource_name}.default.location
              role     = "roles/${global.documentation.example_role}"
              members  = ["user:admin@example.com"]
            }
            ```
          END
        }
      }

      tm_dynamic "section" {
        condition = tm_try(!global.is_regional, true)
        content {
          title   = "Getting Started"
          content = <<-END
            Most common usage of the module:

            ```hcl
            module "${terramate.stack.path.basename}" {
              source = "github.com/mineiros-io/terraform-google-iam//modules/${let.provider}/${terramate.stack.path.basename}?ref=v0.1.3"

              ${global.resource_parent.variable}  = ${global.resource_parent.resource_name}.default.name
              role     = "roles/${global.documentation.example_role}"
              members  = ["user:admin@example.com"]
            }
            ```
          END
        }
      }

      section {
        title   = "Module Argument Reference"
        content = <<-END
          See [variables.tf] for details.
        END

        section {
          title = "Top-level Arguments"

          section {
            title = "Main Resource Configuration"

            tm_dynamic "variable" {
              labels = ["${global.resource_parent.variable}"]
              content {
                required    = true
                type        = string
                description = <<-END
                  ${global.resource_parent.description}.
                END
              }
            }

            tm_dynamic "variable" {
              labels    = [tm_try(global.region_attribute, "location")]
              condition = tm_try(global.is_regional, false)
              content {
                required    = true
                description = "The location used to find the parent resource to bind the IAM policy to"
                type        = string
              }
            }

            variable "members" {
              type        = set(string)
              default     = []
              description = <<-END
                Identities that will be granted the privilege in role. Each entry can have one of the following values:
                ${let.members_patterns}.
              END
            }

            variable "computed_members_map" {
              type        = map(string)
              description = <<-END
                A map of members to replace in 'var.members' or in members of 'policy_bindings' to handle terraform computed values.
              END
              default     = {}
            }

            variable "role" {
              type        = string
              description = <<-END
                The role that should be applied. Note that custom roles must be of the format `[projects|organizations]/{parent-name}/roles/{role-name}`. Omit if `policy_bindings` is set.
              END
            }

            variable "project" {
              type        = string
              description = <<-END
                The ID of the project in which the resource belongs. If it is not provided, the project will be parsed from the identifier of the parent resource. If no project is provided in the parent identifier and no project is specified, the provider project is used.
              END
            }

            variable "authoritative" {
              type        = bool
              default     = true
              description = <<-END
                Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.
              END
            }

            variable "policy_bindings" {
              type           = list(policy_binding)
              description    = <<-END
                A list of IAM policy bindings. Cannot be used at the same time as `role`.
              END
              readme_example = <<-END
                policy_bindings = [{
                  role    = "roles/${global.documentation.example_role}"
                  members = ["user:admin@example.com"]
                }]
              END

              attribute "role" {
                required    = true
                type        = string
                description = <<-END
                  The role that should be applied.
                END
              }

              attribute "members" {
                type        = set(string)
                default     = var.members
                description = <<-END
                  Identities that will be granted the privilege in `role`.
                END
              }

              attribute "condition" {
                type           = object(condition)
                description    = <<-END
                  An IAM Condition for a given binding.
                END
                readme_example = <<-END
                  condition = {
                    expression = "request.time < timestamp(\"2024-01-01T00:00:00Z\")"
                    title      = "expires_after_2023_12_31"
                  }
                END

                attribute "expression" {
                  required    = true
                  type        = string
                  description = <<-END
                    Textual representation of an expression in Common Expression Language syntax.
                  END
                }

                attribute "title" {
                  required    = true
                  type        = string
                  description = <<-END
                    A title for the expression, i.e. a short string describing its purpose.
                  END
                }

                attribute "description" {
                  type        = string
                  description = <<-END
                    An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.
                  END
                }
              }
            }
          }

          section {
            title = "Module Configuration"

            variable "module_enabled" {
              type        = bool
              default     = true
              description = <<-END
                Specifies whether resources in the module will be created.
              END
            }

            variable "module_depends_on" {
              type           = list(dependency)
              description    = <<-END
                A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.
              END
              readme_example = <<-END
                module_depends_on = [
                  google_network.network
                ]
              END
            }
          }
        }
      }

      section {
        title   = "Module Outputs"
        content = <<-END
          The following attributes are exported in the outputs of the module:
        END

        output "iam" {
          type        = object(iam)
          description = <<-END
            All attributes of the created `${terramate.stack.path.basename}_binding` or `${terramate.stack.path.basename}_member` or `${terramate.stack.path.basename}_policy` resource according to the mode.
          END
        }
      }

      section {
        title = "External Documentation"

        section {
          title   = "Google Documentation"
          content = <<-END
            - ${global.documentation.google_docs_url}
          END
        }

        section {
          title   = "Terraform Google Provider Documentation:"
          content = <<-END
            - ${global.documentation.provider_docs_url}
          END
        }
      }

      section {
        title   = "Module Versioning"
        content = <<-END
          This Module follows the principles of [Semantic Versioning (SemVer)].

          Given a version number `MAJOR.MINOR.PATCH`, we increment the:

          1. `MAJOR` version when we make incompatible changes,
          2. `MINOR` version when we add functionality in a backwards compatible manner, and
          3. `PATCH` version when we make backwards compatible bug fixes.
        END

        section {
          title   = "Backward compatibility in `0.0.z` and `0.y.z` version"
          content = <<-END
            - Backward compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
            - Backward compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
          END
        }
      }

      section {
        title   = "About Mineiros"
        content = <<-END
          [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
          that solves development, automation and security challenges in cloud infrastructure.

          Our vision is to massively reduce time and overhead for teams to manage and
          deploy production-grade and secure cloud infrastructure.

          We offer commercial support for all of our modules and encourage you to reach out
          if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
          [Community Discord server][discord].
        END
      }

      section {
        title   = "Reporting Issues"
        content = <<-END
          We use GitHub [Issues] to track community reported issues and missing features.
        END
      }

      section {
        title   = "Contributing"
        content = <<-END
          Contributions are always encouraged and welcome! For the process of accepting changes, we use
          [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
        END
      }

      section {
        title   = "Makefile Targets"
        content = <<-END
          This repository comes with a handy [Makefile].
          Run `make help` to see details on each available target.
        END
      }

      section {
        title   = "License"
        content = <<-END
          [![license][badge-license]][apache20]

          This module is licensed under the Apache License Version 2.0, January 2004.
          Please see [LICENSE] for full details.

          Copyright &copy; 2020-2023 [Mineiros GmbH][homepage]
        END
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
        value = "https://github.com/mineiros-io/terraform-google-iam/blob/main/modules/${let.provider}/${terramate.stack.path.basename}/variables.tf"
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
  }
}
