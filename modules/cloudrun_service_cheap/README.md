# Cloud Run Service (V1, Cost-Optimized)

Deploys a **Google Cloud Run V1 service** using Terraform, optimized for low-cost workloads.

This module uses the Cloud Run V1 API (`google_cloud_run_service`) and exposes knative-style annotations for fine-grained control over scaling and networking. Compared to the V2 module, it gives more direct access to V1-specific settings such as `min_scale` and `container_concurrency`, making it well suited for services that need to scale to zero and minimize idle costs.

Typical use cases include:

- Low-traffic or infrequently used services where cost matters
- Background services that should scale to zero when idle
- Internal services accessible only within a VPC
- Workloads where V1 annotation-based configuration is preferred

---

## Resources Created

This module provisions the following resources:

- `google_cloud_run_service` – Cloud Run V1 service
- `google_cloud_run_service_iam_member` – optional public invocation access (`allUsers`)

---

## Example Usage

```hcl
module "my_cheap_service" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloudrun_service_cheap?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"
  name       = "my-cheap-service"
  image      = "europe-west3-docker.pkg.dev/my-project-id/my-repo/my-image:latest"

  service_account_email = "my-service@my-project-id.iam.gserviceaccount.com"

  cpu_limit    = "1000m"
  memory_limit = "512Mi"

  container_concurrency = 80
  min_scale             = 0

  ingress      = "all"
  allow_public = true

  env_vars = {
    ENV = "prod"
  }
}
```

Example with **VPC connector** for private networking:

```hcl
module "my_internal_service" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloudrun_service_cheap?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"
  name       = "my-internal-service"
  image      = "europe-west3-docker.pkg.dev/my-project-id/my-repo/my-image:latest"

  service_account_email = "my-service@my-project-id.iam.gserviceaccount.com"

  cpu_limit    = "1000m"
  memory_limit = "256Mi"

  container_concurrency = 10
  min_scale             = 0

  ingress       = "internal"
  allow_public  = false

  vpc_connector = "projects/my-project-id/locations/europe-west3/connectors/my-connector"
  vpc_egress    = "ALL_TRAFFIC"
}
```

---

## Inputs

| Name                   | Description                                                                   | Type        | Default      | Required |
| ---------------------- | ----------------------------------------------------------------------------- | ----------- | ------------ | -------- |
| name                   | Name of the Cloud Run service                                                 | string      | n/a          | yes      |
| image                  | Docker image to deploy                                                        | string      | n/a          | yes      |
| region                 | GCP region for the service                                                    | string      | n/a          | yes      |
| project_id             | GCP project ID                                                                | string      | n/a          | yes      |
| service_account_email  | Service account used by the Cloud Run service                                 | string      | n/a          | yes      |
| cpu_limit              | CPU limit for the container (e.g. `"1000m"`, `"2"`)                          | string      | n/a          | yes      |
| memory_limit           | Memory limit for the container (e.g. `"512Mi"`, `"1Gi"`)                    | string      | n/a          | yes      |
| container_concurrency  | Maximum number of concurrent requests per container instance                  | number      | n/a          | yes      |
| ingress                | Ingress traffic setting (e.g. `"all"`, `"internal"`, `"internal-and-cloud-load-balancing"`) | string | `"internal"` | no |
| allow_public           | Whether to grant public (`allUsers`) invocation access                        | bool        | `false`      | no       |
| env_vars               | Environment variables passed to the container                                 | map(string) | `{}`         | no       |
| min_scale              | Minimum number of instances (set to `0` to allow scale-to-zero)              | number      | `0`          | no       |
| vpc_connector          | Optional VPC connector resource name to attach to the service                 | string      | `null`       | no       |
| vpc_egress             | Egress setting for VPC connector (`ALL_TRAFFIC` or `PRIVATE_RANGES_ONLY`)    | string      | n/a          | no       |

---

## Outputs

| Name         | Description                                      |
| ------------ | ------------------------------------------------ |
| url          | Public URL of the deployed Cloud Run service     |
| internal_url | Internal URL of the deployed Cloud Run service   |
| name         | Name of the deployed Cloud Run service           |

---

## Notes

- This module uses the **Cloud Run V1 API**. For new projects, consider using the `cloudrun_service` module (V2) instead, as V2 is the recommended API going forward.
- Setting `min_scale = 0` allows the service to **scale to zero**, eliminating idle costs at the expense of cold start latency.
- `container_concurrency` controls how many requests a single instance handles simultaneously. Lower values reduce memory pressure; higher values improve throughput per instance.
- The `vpc_egress` variable has no default — provide a value whenever `vpc_connector` is set.

---

## License

MIT License © 2026 Coderilla GmbH
