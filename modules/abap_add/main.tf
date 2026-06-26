/*
 *  Assignment of entitlements for an ABAP setup
 */
resource "btp_subaccount_entitlement" "abap__service_instance_plan" {
  subaccount_id = var.subaccount_id
  service_name  = "abap"
  plan_name     = "standard"
}

resource "btp_subaccount_entitlement" "abap__abap_compute_unit" {
  subaccount_id = var.subaccount_id
  service_name  = "abap"
  plan_name     = "abap_compute_unit"
  amount        = 1
}

resource "btp_subaccount_entitlement" "abap__hana_compute_unit" {
  subaccount_id = var.subaccount_id
  service_name  = "abap"
  plan_name     = "hana_compute_unit"
  amount        = 2
}

resource "btp_subaccount_entitlement" "abap__web-router" {
  subaccount_id = var.subaccount_id
  service_name  = "abapcp-web-router"
  plan_name     = "default"
}

/*
 *  Create a service instance for the ABAP web access
 */
resource "btp_subaccount_subscription" "abap_web_access" {
  subaccount_id = var.subaccount_id
  app_name      = "abapcp-web-router"
  plan_name     = "default"
  depends_on    = [btp_subaccount_entitlement.abap__web-router]
}

/*
 *  Create a service instance for the ABAP system
 */
data "cloudfoundry_service_plan" "abap_plan" {
  service_offering_name = "abap"
  name                  = "standard"
}
resource "cloudfoundry_service_instance" "abap_env" {
  name         = "abap-${trimspace(upper(var.abap_sid))}"
  space        = var.cf_space_id
  service_plan = data.cloudfoundry_service_plan.abap_plan.id
  type         = "managed"
  depends_on = [
    btp_subaccount_entitlement.abap__service_instance_plan,
    btp_subaccount_entitlement.abap__abap_compute_unit,
    btp_subaccount_entitlement.abap__hana_compute_unit
  ]
  parameters = jsonencode({
    admin_email            = var.abap_admin_email
    sapsystemname          = trimspace(upper(var.abap_sid))
    is_development_allowed = tobool(var.abap_is_development_allowed)
    size_of_runtime        = 1
    size_of_persistence    = 2
  })
}
/*
resource "btp_subaccount_environment_instance" "abap_env" {
  subaccount_id    = var.subaccount_id
  name             = "abap-${trimspace(upper(var.abap_sid))}"
  environment_type = "sapbtp"
  service_name     = "abap"
  plan_name        = "standard"
  landscape_label  = startswith(var.cf_region, "cf-") ? var.cf_region : "cf-${var.cf_region}"
  depends_on = [
    btp_subaccount_entitlement.abap__service_instance_plan,
    btp_subaccount_entitlement.abap__abap_compute_unit,
    btp_subaccount_entitlement.abap__hana_compute_unit
  ]
  parameters = jsonencode({
    instance_name          = "abap-${trimspace(upper(var.abap_sid))}"
    sapsystemname          = trimspace(upper(var.abap_sid))
    admin_emails           = [var.abap_admin_email]
    is_development_allowed = tobool(var.abap_is_development_allowed)
    login_attribute        = "email"
  })
}
*/

/*
 *  Create a service key for the ABAP system
 */
resource "btp_subaccount_service_binding" "abap_binding" {
  subaccount_id       = var.subaccount_id
  name                = "sk_${trimspace(upper(var.abap_sid))}"
  service_instance_id = cloudfoundry_service_instance.abap_env.id
}
