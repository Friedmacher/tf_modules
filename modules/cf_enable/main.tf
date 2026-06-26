
locals {
  cf_name = "${var.subaccount_subdomain}-cf"
  cf_org  = "${var.subaccount_subdomain}-org"
}

/*
 * Enable Cloud Foundry runtime in the subaccount
 */
resource "btp_subaccount_entitlement" "cloud_foundry" {
  subaccount_id = var.subaccount_id
  service_name  = "cloudfoundry"
  plan_name     = "standard"
}
resource "btp_subaccount_entitlement" "cf_runtime" {
  subaccount_id = var.subaccount_id
  service_name  = "APPLICATION_RUNTIME"
  plan_name     = "MEMORY"
  amount        = 2
}

resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = var.subaccount_id
  name             = local.cf_name
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  landscape_label  = var.cf_region
  plan_name        = "standard"
  parameters = jsonencode({
    instance_name = local.cf_org
  })
}
