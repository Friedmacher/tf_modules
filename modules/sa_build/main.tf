locals {
  subaccount_name      = "SA ${var.project_name} - ${var.stage}"
  subaccount_subdomain = replace(replace(lower("at-${var.project_name}-${var.stage}"), " ", "-"), "/[^a-z0-9-]/", "")
  subaccount_usage     = var.stage == "PRD" ? "USED_FOR_PRODUCTION" : "NOT_USED_FOR_PRODUCTION"
}

/*
 * Create the subaccount
 */
resource "btp_subaccount" "subaccount" {
  name                  = local.subaccount_name
  description           = local.subaccount_name
  subdomain             = local.subaccount_subdomain
  region                = var.subaccount_region
  parent_id             = var.parent_id
  beta_enabled          = false
  skip_auto_entitlement = true
  usage                 = local.subaccount_usage
  labels = {
    "stage"   = ["${var.stage}"]
    "project" = ["${var.project_name}"]
  }
}
