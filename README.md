# Terraform GCP Modules

Reusable **Terraform modules for Google Cloud Platform (GCP)** used to build production-ready cloud infrastructure.

This repository contains modular, opinionated building blocks that simplify deploying common GCP services such as **Cloud Run**, **Cloud Scheduler**, and domain mappings using Terraform.

These modules are actively used in real-world projects and are designed to be **simple, composable, and production-friendly**.

---

## Purpose

Infrastructure setup is often repetitive across projects.
This repository provides reusable Terraform modules that help developers and teams:

- deploy **Cloud Run services**
- configure **Cloud Scheduler jobs**
- manage **custom domains**
- standardize infrastructure patterns
- reduce duplicated Terraform code across projects

The goal is to provide **clean and minimal modules** that can be easily integrated into different infrastructure setups.

---

## Repository Structure

```
terraform-gcp-modules
│
├── modules/          # Reusable Terraform modules
│   ├── cloud_run_service/
│   ├── cloud_run_domain_mapping/
│   └── cloud_scheduler_job/
│
├── examples/         # Example Terraform configurations
│
└── README.md
```

Each module contains:

- `main.tf` – resource definitions
- `variables.tf` – configurable inputs
- `outputs.tf` – exposed outputs
- `versions.tf` – required Terraform/provider versions
- `README.md` – module documentation

---

## Example Usage

Modules can be used directly from this repository.

```
module "cloud_run_service" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloud_run_service?ref=v0.1.0"
  image = "https://path-to-your-docker-image"

  project_id = "my-project-id"
  region     = "europe-west3"
  name       = "example-service"
}
```

Then run:

```
terraform init
terraform apply
```

Terraform will automatically download the module from this repository.

---

## Versioning

Modules are versioned using **Git tags**.

Always reference a specific version when using the modules:

```
?ref=v0.1.0
```

This ensures reproducible infrastructure deployments.

---

## Design Principles

The modules in this repository follow a few simple principles:

- **Composable** – modules can be combined easily
- **Minimal** – avoid unnecessary abstraction
- **Production-ready** – designed for real deployments
- **Cloud-native** – built specifically for GCP services

---

## Contributing

Contributions, improvements, and suggestions are welcome.

If you find an issue or want to propose improvements, feel free to open an issue or submit a pull request.

---

## License

MIT License © 2026 Coderilla GmbH

---

## Maintained By

Maintained by **Coderilla GmbH**
SaaS Infrastructure & Cloud Architecture

More information:
https://coderilla.de
