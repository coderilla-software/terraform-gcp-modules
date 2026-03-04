# Cloud Run Domain Mapping

Maps a **custom domain or subdomain** to an existing Google Cloud Run service using Terraform.

This module creates a Cloud Run domain mapping, allowing a Cloud Run service to be reached via a custom domain (e.g. `app.example.com`) instead of the default `*.run.app` URL.

Typical use cases include:

- Serving a Cloud Run service on a branded custom domain
- Mapping subdomains to different Cloud Run services per environment (e.g. `staging.example.com`, `app.example.com`)
- Decoupling DNS configuration from service deployment

---

## Resources Created

This module provisions the following resource:

- `google_cloud_run_domain_mapping` – domain mapping linking a custom domain to a Cloud Run service

---

## Example Usage

```hcl
module "domain_mapping" {
  source = "git::https://github.com/coderilla-software/terraform-gcp-modules.git//modules/cloudrun_domain?ref=v0.1.0"

  project_id             = "my-project-id"
  region                 = "europe-west3"
  domain_name            = "app.example.com"
  cloud_run_service_name = "my-cloud-run-service"
}
```

---

## Inputs

| Name                   | Description                             | Type   | Default | Required |
| ---------------------- | --------------------------------------- | ------ | ------- | -------- |
| project_id             | GCP project ID                          | string | n/a     | yes      |
| region                 | Region of the Cloud Run service         | string | n/a     | yes      |
| domain_name            | The custom domain or subdomain to map   | string | n/a     | yes      |
| cloud_run_service_name | Name of the Cloud Run service to map to | string | n/a     | yes      |

---

## Notes

- The domain must be **verified** in your GCP project before a mapping can be created. Verify ownership via [Google Search Console](https://search.google.com/search-console).
- Common Pitfall: Make sure to also add the service account email that is used for your terraform deployments as user to the Google Search Console (OWNER). Otherwise the domain mapping will fail.
- After the mapping is created, GCP will provide DNS records (e.g. `CNAME` or `A` records) that need to be added to your DNS provider to complete the setup.
- The `region` must match the region of the target Cloud Run service.

---

## License

MIT License © 2026 Coderilla GmbH
