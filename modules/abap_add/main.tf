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
resource "cloudfoundry_service_instance" "abap_system" {
  name         = "abap-${var.abap_sid}"
  space        = var.cf_space_id
  service_plan = "standard"
  json_params = jsonencode({
    admin_email              = "${var.abap_admin_email}"
    is_development_allowed   = "${var.abap_is_development_allowed}"
    sapsystemname            = "${var.abap_sid}"
    size_of_runtime          = 1
    size_of_persistence      = 2
    size_of_persistence_disk = "auto"
    login_attribute          = "email"
  })
  timeouts {
    create = "2h"
    delete = "2h"
    update = "2h"
  }
}

/*
 *  Create a service key for the ABAP system
 */
resource "cloudfoundry_service_credential_binding" "abap_adt_key" {
  type             = "key"
  name             = "sk_${var.abap_sid}"
  service_instance = cloudfoundry_service_instance.abap_system.id
}









