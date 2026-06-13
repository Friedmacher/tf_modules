locals {
  idp_url              = "${var.idp_host}.accounts.ondemand.com"
  idp_name             = "${var.idp_host} (business users)"
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
  auto_create_shadow_users = TRUE
  available_for_user_logon = TRUE
  domain                   = "Default"
  link_text                = "Identity provider for business users"
  status                   = "active"
}
