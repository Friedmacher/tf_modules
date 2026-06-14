/*
 * Assign the Subaccount Administrator role collection to the sa-administrators group in the subaccount. This group is used for users who need administrative access to the subaccount, allowing them to manage resources and configurations within the subaccount effectively.
 */
resource "btp_subaccount_role_collection_assignment" "sa_administrators" {
  subaccount_id        = var.subaccount_id
  origin               = var.btp_platform_idp
  role_collection_name = "Subaccount Administrator"
  group_name           = "sa-administrators"
}

resource "btp_subaccount_role_collection_assignment" "sa_viewers" {
  subaccount_id        = var.subaccount_id
  origin               = var.btp_platform_idp
  role_collection_name = "Subaccount Viewer"
  group_name           = "sa-viewers"
}
