locals {
  idp_host = split(".", var.btp_idp)[0]
  idp_name = "${local.idp_host} (business users)"
}

/*
 * Establish trust to SAP Cloud Identity Provider (IDP)
 */
resource "btp_subaccount_trust_configuration" "create_trust" {
  subaccount_id            = var.subaccount_id
  identity_provider        = var.btp_idp
  name                     = local.idp_name
  description              = "IAS tenant ${local.idp_host} (OpenID Connect)"
  origin                   = "custom.idp"
  auto_create_shadow_users = true
  available_for_user_logon = true
  link_text                = "Identity provider for business users"
  status                   = "active"
}

/*
 * Disable SAP default IDP for user logon, so that users can only logon via the configured IAS IDP
  This is required to avoid that users can logon with their SAP S-User credentials, which are not managed in IAS
 */
resource "btp_subaccount_security_settings" "change_default_idp" {
  subaccount_id                        = var.subaccount_id
  default_idp_available_for_user_logon = false
}


#resource "btp_subaccount_trust_configuration" "change_default_idp" {
#  subaccount_id            = var.subaccount_id
#  identity_provider        = "sap.default"
#  available_for_user_logon = false
#}
