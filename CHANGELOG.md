# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.3]

### Changed

- Upgraded tool versions

### Added

- Generated the google_cloud_tasks_queue_iam module

### Fixed

- Removed the Terraform plugin cache that caused concurrent `terraform init` to fail

## [0.1.2]

### Added

- Generated the google_dns_managed_zone_iam module

## [0.1.1]

### Changed

- Updated minimum provider version to 4.50 (earliest working release)

## [0.1.0]

### Added

- Initial Implementation
- Generated the following modules:
  - google_artifact_registry_repository_iam
  - google_cloud_run_service_iam
  - google_cloud_run_v2_job_iam
  - google_cloud_run_v2_service_iam

[unreleased]: https://github.com/mineiros-io/terraform-google-iam/compare/v0.1.3...HEAD
[0.1.3]: https://github.com/mineiros-io/terraform-google-iam/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/mineiros-io/terraform-google-iam/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/mineiros-io/terraform-google-iam/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/mineiros-io/terraform-google-iam/releases/tag/v0.1.0
