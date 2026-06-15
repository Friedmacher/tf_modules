resource "cloudfoundry_org_role" "org_user" {
  username = var.user_name
  origin   = var.idp_origin
  type     = "organization_user"
  org      = var.cf_org_id
}

resource "cloudfoundry_org_role" "org_manager" {
  username = var.user_name
  origin   = var.idp_origin
  type     = "organization_manager"
  org      = var.cf_org_id
}

resource "cloudfoundry_space_role" "space_manager" {
  username = var.user_name
  origin   = var.idp_origin
  type     = "space_manager"
  space    = var.cf_space_id
}

resource "cloudfoundry_space_role" "space_developer" {
  username = var.user_name
  origin   = var.idp_origin
  type     = "space_developer"
  space    = var.cf_space_id
}
