[<img src="https://raw.githubusercontent.com/mineiros-io/brand/851a473f65dd7d857a9311ca255c6e2763c72afe/mineiros-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-google-iam)

[![Build Status](https://github.com/mineiros-io/terraform-google-iam/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-google-iam/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-google-iam/releases)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Google Provider Version](https://img.shields.io/badge/google-4-1A73E8.svg?logo=terraform)](https://github.com/terraform-providers/terraform-provider-google/releases)
[![Join Discord](https://img.shields.io/badge/Discord-Terramate-7289d9.svg?logo=discord)](https://terramate.io/discord)

# Google Artifact Registry Repository IAM Terraform Module

A [Terraform](https://www.terraform.io) module to create a [Google Artifact Registry Repository IAM](https://cloud.google.com/artifact-registry/docs/access-control) on [Google Cloud Services (GCP)](https://cloud.google.com/).

**_This module supports Terraform version 1
and is compatible with the Terraform Google Provider version 4._**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Top-level Arguments](#top-level-arguments)
    - [Main Resource Configuration](#main-resource-configuration)
    - [Module Configuration](#module-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Google Documentation](#google-documentation)
  - [Terraform Google Provider Documentation:](#terraform-google-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backward compatibility in `0.0.z` and `0.y.z` version](#backward-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following Terraform resources:

- `google_artifact_registry_repository_iam_binding`
- `google_artifact_registry_repository_iam_member`
- `google_artifact_registry_repository_iam_policy`

## Getting Started

Most common usage of the module:

```hcl
module "google_artifact_registry_repository_iam" {
  source = "github.com/mineiros-io/terraform-google-iam//modules/google/google_artifact_registry_repository_iam?ref=v0.1.0"

  repository  = google_artifact_registry_repository.default.name
  location = google_artifact_registry_repository.default.location
  role     = "roles/artifactregistry.reader"
  members  = ["user:admin@example.com"]
}
```

## Module Argument Reference

See [variables.tf] for details.

### Top-level Arguments

#### Main Resource Configuration

- [**`repository`**](#var-repository): *(**Required** `string`)*<a name="var-repository"></a>

  Name of Artifact Registry Repository resource the IAM is applied to.

- [**`location`**](#var-location): *(**Required** `string`)*<a name="var-location"></a>

  The location used to find the parent resource to bind the IAM policy to.

- [**`members`**](#var-members): *(Optional `set(string)`)*<a name="var-members"></a>

  Identities that will be granted the privilege in role. Each entry can have one of the following values:
  `allUsers`, `allAuthenticatedUsers`, `user:{emailid}`, `serviceAccount:{emailid}`, `group:{emailid}`, `domain:{domain}`, `projectOwner:{projectid}`, `projectEditor:{projectid}`, `projectViewer:{projectid}`, `computed:{identifier}`.

  Default is `[]`.

- [**`computed_members_map`**](#var-computed_members_map): *(Optional `map(string)`)*<a name="var-computed_members_map"></a>

  A map of members to replace in 'var.members' or in members of 'policy_bindings' to handle terraform computed values.

  Default is `{}`.

- [**`role`**](#var-role): *(Optional `string`)*<a name="var-role"></a>

  The role that should be applied. Note that custom roles must be of the format `[projects|organizations]/{parent-name}/roles/{role-name}`. Omit if `policy_bindings` is set.

- [**`project`**](#var-project): *(Optional `string`)*<a name="var-project"></a>

  The ID of the project in which the resource belongs. If it is not provided, the project will be parsed from the identifier of the parent resource. If no project is provided in the parent identifier and no project is specified, the provider project is used.

- [**`authoritative`**](#var-authoritative): *(Optional `bool`)*<a name="var-authoritative"></a>

  Whether to exclusively set (authoritative mode) or add (non-authoritative/additive mode) members to the role.

  Default is `true`.

- [**`policy_bindings`**](#var-policy_bindings): *(Optional `list(policy_binding)`)*<a name="var-policy_bindings"></a>

  A list of IAM policy bindings. Cannot be used at the same time as `role`.

  Example:

  ```hcl
  policy_bindings = [{
    role    = "roles/artifactregistry.reader"
    members = ["user:admin@example.com"]
  }]
  ```

  Each `policy_binding` object in the list accepts the following attributes:

  - [**`role`**](#attr-policy_bindings-role): *(**Required** `string`)*<a name="attr-policy_bindings-role"></a>

    The role that should be applied.

  - [**`members`**](#attr-policy_bindings-members): *(Optional `set(string)`)*<a name="attr-policy_bindings-members"></a>

    Identities that will be granted the privilege in `role`.

    Default is `var.members`.

  - [**`condition`**](#attr-policy_bindings-condition): *(Optional `object(condition)`)*<a name="attr-policy_bindings-condition"></a>

    An IAM Condition for a given binding.

    Example:

    ```hcl
    condition = {
      expression = "request.time < timestamp(\"2024-01-01T00:00:00Z\")"
      title      = "expires_after_2023_12_31"
    }
    ```

    The `condition` object accepts the following attributes:

    - [**`expression`**](#attr-policy_bindings-condition-expression): *(**Required** `string`)*<a name="attr-policy_bindings-condition-expression"></a>

      Textual representation of an expression in Common Expression Language syntax.

    - [**`title`**](#attr-policy_bindings-condition-title): *(**Required** `string`)*<a name="attr-policy_bindings-condition-title"></a>

      A title for the expression, i.e. a short string describing its purpose.

    - [**`description`**](#attr-policy_bindings-condition-description): *(Optional `string`)*<a name="attr-policy_bindings-condition-description"></a>

      An optional description of the expression. This is a longer text which describes the expression, e.g. when hovered over it in a UI.

#### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies. Any object can be _assigned_ to this list to define a hidden external dependency.

  Example:

  ```hcl
  module_depends_on = [
    google_network.network
  ]
  ```

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`iam`**](#output-iam): *(`object(iam)`)*<a name="output-iam"></a>

  All attributes of the created `google_artifact_registry_repository_iam_binding` or `google_artifact_registry_repository_iam_member` or `google_artifact_registry_repository_iam_policy` resource according to the mode.

## External Documentation

### Google Documentation

- https://cloud.google.com/artifact-registry/docs/access-control

### Terraform Google Provider Documentation:

- https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository_iam

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backward compatibility in `0.0.z` and `0.y.z` version

- Backward compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backward compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Discord server][discord].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2023 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-google-iam
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-build]: https://github.com/mineiros-io/terraform-google-iam/workflows/Tests/badge.svg
[badge-semver]: https://img.shields.io/github/v/tag/mineiros-io/terraform-google-iam.svg?label=latest&sort=semver
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[badge-terraform]: https://img.shields.io/badge/Terraform-1.x-623CE4.svg?logo=terraform
[badge-slack]: https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack
[build-status]: https://github.com/mineiros-io/terraform-google-iam/actions
[releases-github]: https://github.com/mineiros-io/terraform-google-iam/releases
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[badge-tf-gcp]: https://img.shields.io/badge/google-3.x-1A73E8.svg?logo=terraform
[releases-google-provider]: https://github.com/terraform-providers/terraform-provider-google/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[discord]: https://terramate.io/discord
[terraform]: https://www.terraform.io
[gcp]: https://cloud.google.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-google-iam/blob/main/modules/google/google_artifact_registry_repository_iam/variables.tf
[issues]: https://github.com/mineiros-io/terraform-google-iam/issues
[license]: https://github.com/mineiros-io/terraform-google-iam/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-google-iam/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-google-iam/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-google-iam/blob/main/CONTRIBUTING.md
