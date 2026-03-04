# Cloud Tasks Queue

Deploys a **Google Cloud Tasks queue** using Terraform.

This module provisions a task queue with configurable rate limits and retry behavior. It is typically used to decouple workloads by queuing HTTP tasks for asynchronous processing by workers such as Cloud Run services or Cloud Functions.

Typical use cases include:

- Offloading slow or resource-intensive operations from request handlers
- Reliable async task execution with automatic retries
- Rate-controlled dispatch of HTTP calls to downstream services
- Background job processing pipelines

---

## Resources Created

This module provisions the following resource:

- `google_cloud_tasks_queue` – Cloud Tasks queue with rate limiting and retry configuration

---

## Example Usage

```hcl
module "task_queue" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloud_tasks?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"
  name       = "my-task-queue"
}
```

Example with custom rate limits and retry configuration:

```hcl
module "task_queue" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloud_tasks?ref=v0.1.0"

  project_id = "my-project-id"
  region     = "europe-west3"
  name       = "background-jobs"

  max_concurrent_dispatches = 10
  max_dispatches_per_second = 100

  max_attempts       = 5
  max_retry_duration = "30s"
  min_backoff        = "2s"
  max_backoff        = "120s"
  max_doublings      = 4
}
```

---

## Inputs

| Name                      | Description                                              | Type         | Default  | Required |
| ------------------------- | -------------------------------------------------------- | ------------ | -------- | -------- |
| name                      | Name of the Cloud Tasks queue                            | string       | n/a      | yes      |
| region                    | Region for the Cloud Tasks queue                         | string       | n/a      | yes      |
| project_id                | GCP project ID                                           | string       | n/a      | yes      |
| max_concurrent_dispatches | Maximum number of concurrent tasks that can be dispatched | number       | `5`      | no       |
| max_dispatches_per_second | Maximum number of tasks that can be dispatched per second | number       | `500`    | no       |
| max_attempts              | Maximum number of attempts for a task                    | number       | `3`      | no       |
| max_retry_duration        | Maximum total retry duration                             | string       | `"10s"`  | no       |
| min_backoff               | Minimum backoff duration between retries                 | string       | `"1s"`   | no       |
| max_backoff               | Maximum backoff duration between retries                 | string       | `"60s"`  | no       |
| max_doublings             | Maximum number of doublings in the backoff period        | number       | `3`      | no       |
| invoker_members           | List of members allowed to enqueue tasks (unused)        | list(string) | `[]`     | no       |

---

## Outputs

| Name           | Description                       |
| -------------- | --------------------------------- |
| queue_name     | Name of the Cloud Tasks queue     |
| queue_location | Location of the Cloud Tasks queue |
| queue_id       | ID of the Cloud Tasks queue       |

---

## Notes

- Duration values for `min_backoff`, `max_backoff`, and `max_retry_duration` must be provided as **strings with a unit suffix** (e.g. `"1s"`, `"60s"`).
- The backoff between retries doubles up to `max_doublings` times, then increases linearly.
- The `invoker_members` variable is defined but the corresponding IAM binding is currently commented out in `main.tf`. Enable it if you need to grant `roles/cloudtasks.taskRunner` to specific identities.

---

## License

MIT License © 2026 Coderilla GmbH
