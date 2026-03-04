# Cloud Scheduler HTTP Job

Deploys a **Google Cloud Scheduler job** that periodically sends an HTTP request to a target URL.

This module is typically used to trigger scheduled tasks such as:

- Keeping **Cloud Run services warm**
- Triggering internal APIs
- Running periodic maintenance tasks
- Calling webhook endpoints
- Executing lightweight scheduled jobs

The module supports optional **OIDC authentication**, allowing the request to be authenticated when calling protected services such as private Cloud Run endpoints.

---

## Resources Created

This module provisions the following resource:

- `google_cloud_scheduler_job` – scheduled HTTP job

---

## Example Usage

```hcl
module "cloud_run_keepalive" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloud_scheduler_job?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"

  name       = "cloud-run-keepalive"
  target_url = "https://my-service-abcdefg.a.run.app"

  schedule = "*/12 * * * *"
}
```

Example with **OIDC authentication** for protected services:

```hcl
module "secure_scheduler" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloud_scheduler_job?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"

  name       = "internal-service-trigger"
  target_url = "https://internal-service-abcdefg.a.run.app"

  send_id_token        = true
  service_account_email = "scheduler@my-project-id.iam.gserviceaccount.com"
}
```

---

## Inputs

| Name                  | Description                                                                          | Type   | Default          | Required |
| --------------------- | ------------------------------------------------------------------------------------ | ------ | ---------------- | -------- |
| name                  | Name of the Cloud Scheduler job                                                      | string | n/a              | yes      |
| target_url            | The URL that will be triggered by the scheduler                                      | string | n/a              | yes      |
| schedule              | Cron schedule for the job                                                            | string | `"*/12 * * * *"` | no       |
| project_id            | GCP Project ID                                                                       | string | n/a              | yes      |
| region                | GCP region where the scheduler job will be created                                   | string | n/a              | yes      |
| send_id_token         | Whether an OIDC ID token should be attached to the request                           | bool   | `false`          | no       |
| service_account_email | Service account used to generate the OIDC token (required if `send_id_token = true`) | string | `""`             | no       |
| audience              | OIDC audience claim (defaults to `target_url` if empty)                              | string | `""`             | no       |

---

## Outputs

| Name     | Description                             |
| -------- | --------------------------------------- |
| job_name | Name of the created Cloud Scheduler job |

---

## Notes

- The scheduler sends an **HTTP GET request** to the configured `target_url`.
- By default, the job runs every **12 minutes** (`*/12 * * * *`).
- If `send_id_token` is enabled, the request will include an **OIDC ID token** generated using the provided service account.
- This is commonly required when calling **private Cloud Run services** or other authenticated endpoints.

---

## License

MIT License © 2026 Coderilla GmbH
