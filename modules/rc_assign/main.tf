# Assign the Subaccount Administrator role collection to the sa_administrators group in the subaccount.
resource "btp_subaccount_role_collection_assignment" "sa_administrators" {
  subaccount_id        = var.subaccount_id
  origin               = var.btp_platform_idp
  role_collection_name = "Subaccount Administrator"
  group_name           = "sa_administrators"
}

# Assign the Subaccount Viewer role collection to the sa_viewers group in the subaccount.
resource "btp_subaccount_role_collection_assignment" "sa_viewers" {
  subaccount_id        = var.subaccount_id
  origin               = var.btp_platform_idp
  role_collection_name = "Subaccount Viewer"
  group_name           = "sa_viewers"
}
