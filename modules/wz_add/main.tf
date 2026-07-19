# Assignment of entitlements for SAP Workzone and Task Center
resource "btp_subaccount_entitlement" "workzone_entitlement" {
  subaccount_id = var.subaccount_id
  service_name  = "SAPLaunchpad"
  plan_name     = "standard"
}

resource "btp_subaccount_entitlement" "workzone_api_entitlement" {
  subaccount_id = var.subaccount_id
  service_name  = "build-workzone-standard"
  plan_name     = "standard"
}

resource "btp_subaccount_entitlement" "task_center_entitlement" {
  subaccount_id = var.subaccount_id
  service_name  = "one-inbox-service"
  plan_name     = "all-tasks"
}

# create a subscription to workzone
resource "btp_subaccount_subscription" "workzone" {
  subaccount_id = var.subaccount_id
  app_name      = "SAPLaunchpad"
  plan_name     = "standard"
  depends_on = [
    btp_subaccount_entitlement.workzone_entitlement,
    btp_subaccount_entitlement.workzone_api_entitlement
  ]
}

# create a subscription to task center
resource "btp_subaccount_subscription" "task_center" {
  subaccount_id = var.subaccount_id
  app_name      = "one-inbox-service"
  plan_name     = "all-tasks"
  depends_on = [
    btp_subaccount_entitlement.task_center_entitlement,
    btp_subaccount_subscription.workzone
  ]
}

# assign the Launchpad_Admin role collection to the wz_administrators group
resource "btp_subaccount_role_collection_assignment" "wz_administrators" {
  subaccount_id        = var.subaccount_id
  origin               = var.btp_platform_idp
  role_collection_name = "Launchpad_Admin"
  group_name           = "wz_administrators"
  depends_on = [
    btp_subaccount_subscription.workzone,
    btp_subaccount_subscription.task_center
  ]
}

# create a service plan instance by plan and offering name
resource "btp_subaccount_service_instance" "workzone_api" {
  subaccount_id         = var.subaccount_id
  serviceplan_name      = "standard"
  service_offering_name = "build-workzone-standard"
  name                  = "workzone-api-cf"
  depends_on = [
    btp_subaccount_subscription.workzone,
    btp_subaccount_subscription.task_center
  ]
}
