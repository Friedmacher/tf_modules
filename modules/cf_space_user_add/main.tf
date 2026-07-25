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
