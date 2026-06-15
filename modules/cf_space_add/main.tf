resource "cloudfoundry_space" "space" {
  name = var.cf_space_name
  org  = var.cf_org_id
}
