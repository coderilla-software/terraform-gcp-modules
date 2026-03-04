# Contributing

Thanks for your interest in contributing! 🎉

This repository contains reusable Terraform modules for Google Cloud Platform (GCP).

## How to contribute

### 1) Report bugs / request features

- Open a GitHub Issue with a clear title and description
- Include:
  - Terraform version
  - `hashicorp/google` provider version
  - Minimal config to reproduce (sanitized)

### 2) Submit a pull request

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/<short-name>`
3. Make changes (keep modules minimal and composable)
4. Run formatting:
   - `terraform fmt -recursive`
5. Add/update:
   - module `README.md` (inputs/outputs + examples)
   - examples if behavior changes
6. Open a PR with:
   - what changed
   - why
   - any breaking changes

## Module conventions

Please follow these conventions for new modules:

- Folder structure:
  - `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, `README.md`
- Naming:
  - `project_id`, `region`, `name`, `labels`, `service_account_email`
- Prefer secure defaults (least privilege)
- Avoid pinning exact provider versions inside modules

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
