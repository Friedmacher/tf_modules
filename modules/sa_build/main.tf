locals {
  subaccount_name      = "SA ${var.project_name} - ${var.stage}"
  subaccount_subdomain = replace(replace(lower("at-${var.project_name}-${var.stage}"), " ", "-"), "/[^a-z0-9-]/", "")
  subaccount_usage     = var.stage == "PRD" ? "USED_FOR_PRODUCTION" : "NOT_USED_FOR_PRODUCTION"
  idp_host             = split(".", var.btp_idp)[0]
  idp_name             = "${local.idp_host} (business users)"
}

# Create the subaccount
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

# Establish trust to SAP Cloud Identity Provider (IDP)
resource "btp_subaccount_trust_configuration" "create_trust" {
  subaccount_id            = btp_subaccount.subaccount.id
  identity_provider        = var.btp_idp
  name                     = local.idp_name
  origin                   = "custom.idp"
  auto_create_shadow_users = true
  available_for_user_logon = true
  link_text                = "Identity provider for business users"
  status                   = "active"
}

# Assign the Subaccount Administrator role collection to the sa_administrators group in the subaccount.
resource "btp_subaccount_role_collection_assignment" "sa_administrators" {
  subaccount_id        = btp_subaccount.subaccount.id
  origin               = var.btp_platform_idp
  role_collection_name = "Subaccount Administrator"
  group_name           = "sa_administrators"
}

# Assign the Subaccount Viewer role collection to the sa_viewers group in the subaccount.
resource "btp_subaccount_role_collection_assignment" "sa_viewers" {
  subaccount_id        = btp_subaccount.subaccount.id
  origin               = var.btp_platform_idp
  role_collection_name = "Subaccount Viewer"
  group_name           = "sa_viewers"
}
