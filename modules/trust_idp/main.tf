locals {
  idp_url              = "${var.btp_idp}.accounts.ondemand.com"
  idp_name             = "${var.btp_idp} (business users)"
}

/*
 * Esteblish trust to SAP Cloud Identity Provider (IDP)
 */
 resource "btp_subaccount_trust_configuration" "create_trust" {
  subaccount_id            = var.subaccount_id
  identity_provider        = local.idp_url
  name                     = local.idp_name
  description              = "Identity provider for business users"
  origin                   = "sap.custom"
  auto_create_shadow_users = true
  available_for_user_logon = true
  domain                   = "Default"
  link_text                = "Identity provider for business users"
  status                   = "active"
}
