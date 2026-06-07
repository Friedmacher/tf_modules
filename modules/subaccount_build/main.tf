locals {
  subaccount_name      = "SA ${var.project_name} - ${var.stage}"
  subaccount_subdomain = replace(replace(lower("at-${var.project_name}-${var.stage}"), " ", "-"), "/[^a-z0-9-]/", "")
}

/*
 * Create the subaccount
 */
resource "btp_subaccount" "subaccount" {
  name        = local.subaccount_name
  description = local.subaccount_name
  subdomain   = local.subaccount_subdomain
  region      = var.subaccount_region
  parent_id   = var.parent_id
  labels = {
    "stage" = ["${var.stage}"]
  }
}
