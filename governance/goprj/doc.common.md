[Code of Conduct]:    .github/CODE_OF_CONDUCT.md
[Contributing Guide]: .github/CONTRIBUTING.md

# Governance

This repository follows standard governance and documentation components:

| Component | Description |
| - | - |
| Licensing | Predefined open-source license. |
| [Code of Conduct] | A community standards for all participants. |
| [Contributing Guide] | Explains how to contribute, including reporting issues, submitting pull requests, and development workflow. |
| Continuous Integration | Automated build, vet, and test executed on each push and pull request. |
| [CHANGELOG](./CHANGELOG.md) | Tracks project changes across versions. |
| README | This document. Provides project overview, purpose, structure, and onboarding information for users and contributors. |


# Continuous Integration

This repository uses GitHub Actions (Workflow file: `.github/workflows/ci.yaml`) for automated tasks and quality control.

The CI pipeline performs:

- module validation (`go mod tidy`)
- static analysis (`go vet`)
- tests execution (`go test`)

