# VPC Connector

Deploys a **Serverless VPC Access connector** and the associated VPC network using Terraform.

This module creates a dedicated VPC network and a VPC Access connector, enabling serverless services such as Cloud Run or Cloud Functions to reach private resources inside a VPC (e.g. Cloud SQL, Memorystore, internal APIs) without exposing them to the public internet.

The connector is provisioned with `e2-micro` instances to keep costs low, with a baseline of 2 instances and a maximum of 3.

Typical use cases include:

- Connecting Cloud Run services to a private Cloud SQL instance
- Accessing Memorystore (Redis) from a serverless service
- Routing egress traffic through a VPC for internal service-to-service communication
- Isolating backend infrastructure from the public internet

---

## Resources Created

This module provisions the following resources:

- `google_compute_network` – dedicated VPC network
- `google_vpc_access_connector` – Serverless VPC Access connector

---

## Example Usage

```hcl
module "vpc_connector" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/vpc_connector?ref=v0.1.0"

  project_id      = "my-project-id"
  region          = "europe-west3"
  vpc_name        = "my-vpc"
  connector_name  = "my-vpc-connector"
  subnet_name     = "my-subnet"
  subnet_ip_range = "10.8.0.0/28"
}
```

The output `vpc_connector_id` can then be passed to the `cloudrun_service` or `cloudrun_service_cheap` modules:

```hcl
module "my_service" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloudrun_service?ref=v0.1.0"

  # ...

  vpc_connector = module.vpc_connector.vpc_connector_id
  vpc_egress    = "ALL_TRAFFIC"
}
```

---

## Inputs

| Name             | Description                                              | Type   | Default | Required |
| ---------------- | -------------------------------------------------------- | ------ | ------- | -------- |
| project_id       | GCP project ID                                           | string | n/a     | yes      |
| region           | GCP region for the VPC and connector                     | string | n/a     | yes      |
| vpc_name         | Name of the VPC network to create                        | string | n/a     | yes      |
| connector_name   | Name of the VPC Access connector                         | string | n/a     | yes      |
| subnet_name      | Name of the subnet (used for reference, currently unused) | string | n/a    | yes      |
| subnet_ip_range  | IP CIDR range used by the connector (must be `/28`)      | string | n/a     | yes      |

---

## Outputs

| Name               | Description                          |
| ------------------ | ------------------------------------ |
| vpc_connector_id   | Full resource ID of the VPC connector |

---

## Notes

- The `subnet_ip_range` must be a `/28` CIDR block (16 IPs) that does not overlap with any existing subnet in your VPC. Example: `"10.8.0.0/28"`.
- The subnet resource is currently commented out in `main.tf` — the connector uses the IP range directly on the VPC network rather than a named subnet.
- The connector uses `e2-micro` instances with `min_instances = 2` and `max_instances = 3` for a cost-efficient baseline. Note that a minimum of 2 instances means there is a small always-on cost even when idle.
- The `Serverless VPC Access API` (`vpcaccess.googleapis.com`) must be enabled in your GCP project before applying this module.

---

## License

MIT License © 2026 Coderilla GmbH
