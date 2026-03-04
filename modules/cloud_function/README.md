# Cloud Function (Gen2)

Deploys a **Google Cloud Function (2nd generation)** using Terraform.

This module packages a zipped function archive, uploads it to a temporary GCS bucket, and deploys the function as a **Cloud Functions Gen2 service**. The function is exposed via HTTPS and can optionally serve as a proxy for external services such as webhooks.

Typical use cases include:

- Webhook receivers (Stripe, GitHub, etc.)
- Lightweight API endpoints
- Proxying requests to internal services
- Event-based integrations

---

## Resources Created

This module provisions the following resources:

- `google_storage_bucket` – temporary bucket for the function source archive
- `google_storage_bucket_object` – uploaded zipped source code
- `google_cloudfunctions2_function` – deployed Cloud Function (Gen2)
- `google_cloud_run_service_iam_member` – optional public invocation access

---

## Example Usage

```hcl
module "stripe_webhook_function" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloud_function?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"
  env        = "prod"

  name        = "stripe-webhook-proxy"
  description = "Stripe webhook receiver"

  runtime     = "python311"
  entry_point = "handler"

  source_zip_path = "./function.zip"

  service_account_email = "function-sa@my-project-id.iam.gserviceaccount.com"

  environment_variables = {
    ENV = "prod"
  }
}
```

After deployment, the function will be accessible via the output URL.

---

## Inputs

| Name                       | Description                                                                | Type        | Default                    | Required |
| -------------------------- | -------------------------------------------------------------------------- | ----------- | -------------------------- | -------- |
| project_id                 | GCP project ID                                                             | string      | n/a                        | yes      |
| region                     | GCP region                                                                 | string      | n/a                        | yes      |
| env                        | Environment identifier (e.g. dev, staging, prod)                           | string      | n/a                        | yes      |
| name                       | Name of the Cloud Function                                                 | string      | n/a                        | yes      |
| description                | Optional description for the function                                      | string      | `"Generic cloud function"` | no       |
| source_zip_path            | Path to the zipped function source code                                    | string      | n/a                        | yes      |
| entry_point                | Entry point function name inside the code                                  | string      | n/a                        | yes      |
| runtime                    | Runtime environment (e.g. python311, nodejs20)                             | string      | n/a                        | yes      |
| service_account_email      | Service account used by the function                                       | string      | n/a                        | yes      |
| environment_variables      | Environment variables for the function                                     | map(string) | `{}`                       | no       |
| memory                     | Memory allocation                                                          | string      | `"512M"`                   | no       |
| available_cpu              | CPU allocation                                                             | string      | `"1"`                      | no       |
| timeout_seconds            | Function execution timeout                                                 | number      | `15`                       | no       |
| ingress_settings           | Ingress settings (ALLOW_ALL, ALLOW_INTERNAL_ONLY, ALLOW_INTERNAL_AND_GCLB) | string      | `"ALLOW_ALL"`              | no       |
| max_instances              | Maximum number of instances                                                | number      | `10`                       | no       |
| max_concurrent_invocations | Maximum concurrent invocations per instance                                | number      | `20`                       | no       |
| labels                     | Optional labels applied to the function                                    | map(string) | `{}`                       | no       |

---

## Outputs

| Name                     | Description                                     |
| ------------------------ | ----------------------------------------------- |
| stripe_webhook_proxy_url | Public HTTPS URL of the deployed Cloud Function |
| name                     | Name of the deployed Cloud Function             |

---

## Notes

- The function source code must be provided as a **zip archive**.
- The module automatically uploads the archive to a temporary GCS bucket before deployment.
- By default, the function is configured to allow **public invocation** (`allUsers`).

Adjust the `ingress_settings` and IAM configuration if you need a more restricted setup.

---

## License

MIT License © 2026 Coderilla GmbH
