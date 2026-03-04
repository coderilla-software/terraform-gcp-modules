# Cloud Run Service (V2)

Deploys a **Google Cloud Run V2 service** using Terraform.

This module provisions a containerized Cloud Run service with configurable resources, environment variables, ingress settings, and optional VPC connector support. It can optionally expose the service publicly via IAM.

Typical use cases include:

- Deploying web applications and APIs
- Running backend services with public or internal access
- Hosting event-driven microservices
- Serving containerized workloads with optional private networking via VPC

---

## Resources Created

This module provisions the following resources:

- `google_cloud_run_v2_service` – Cloud Run V2 service
- `google_cloud_run_v2_service_iam_member` – optional public invocation access (`allUsers`)

---

## Example Usage

```hcl
module "my_service" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloudrun_service?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"
  name       = "my-service"
  image      = "europe-west3-docker.pkg.dev/my-project-id/my-repo/my-image:latest"

  service_account_email = "my-service@my-project-id.iam.gserviceaccount.com"

  ingress      = "INGRESS_TRAFFIC_ALL"
  allow_public = true

  env_vars = {
    ENV = "prod"
  }
}
```

Example with **VPC connector** for private networking:

```hcl
module "my_private_service" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloudrun_service?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"
  name       = "my-private-service"
  image      = "europe-west3-docker.pkg.dev/my-project-id/my-repo/my-image:latest"

  service_account_email = "my-service@my-project-id.iam.gserviceaccount.com"

  ingress       = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  allow_public  = false

  vpc_connector = "projects/my-project-id/locations/europe-west3/connectors/my-connector"
  vpc_egress    = "ALL_TRAFFIC"
}
```

---

## Inputs

| Name                   | Description                                                         | Type        | Default          | Required |
| ---------------------- | ------------------------------------------------------------------- | ----------- | ---------------- | -------- |
| name                   | Name of the Cloud Run service                                       | string      | n/a              | yes      |
| image                  | Docker image to deploy                                              | string      | n/a              | yes      |
| region                 | GCP region for the service                                          | string      | n/a              | yes      |
| project_id             | GCP project ID                                                      | string      | n/a              | yes      |
| service_account_email  | Service account used by the Cloud Run service                       | string      | n/a              | yes      |
| ingress                | Ingress traffic setting (e.g. `INGRESS_TRAFFIC_ALL`, `INGRESS_TRAFFIC_INTERNAL_ONLY`) | string | n/a | yes |
| allow_public           | Whether to grant public (`allUsers`) invocation access              | bool        | `false`          | no       |
| env_vars               | Environment variables passed to the container                       | map(string) | `{}`             | no       |
| cpu_limit              | CPU limit for the container                                         | string      | `"1"`            | no       |
| memory_limit           | Memory limit for the container                                      | string      | `"512Mi"`        | no       |
| vpc_connector          | Optional VPC connector resource name to attach to the service       | string      | `null`           | no       |
| vpc_egress             | Egress setting for VPC connector (`ALL_TRAFFIC` or `PRIVATE_RANGES_ONLY`) | string | `"ALL_TRAFFIC"` | no |

---

## Outputs

| Name         | Description                              |
| ------------ | ---------------------------------------- |
| url          | Public URL of the deployed Cloud Run service |
| internal_url | Internal URL of the deployed Cloud Run service |
| name         | Name of the deployed Cloud Run service   |

---

## Notes

- `deletion_protection` is set to `false` by default, allowing the service to be destroyed via Terraform.
- Set `allow_public = true` together with `ingress = "INGRESS_TRAFFIC_ALL"` for a publicly accessible service.
- The `vpc_connector` must already exist before applying this module. Use it to route egress traffic through a VPC for access to private resources such as Cloud SQL or internal services.

---

## License

MIT License © 2026 Coderilla GmbH
