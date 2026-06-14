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
  origin                   = "custom.idp"
  auto_create_shadow_users = true
  available_for_user_logon = true
  link_text                = "Identity provider for business users"
  status                   = "active"
}
