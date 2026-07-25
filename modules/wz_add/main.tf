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

# Create the Cloud Foundry Space
resource "cloudfoundry_space" "wz_space" {
  name = "workzone"
  org  = var.cf_org_id
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

# Assign the Launchpad_Admin role collection to the wz_administrators group
resource "btp_subaccount_role_collection_assignment" "wz_administrators" {
  subaccount_id        = var.subaccount_id
  origin               = var.btp_platform_idp
  role_collection_name = "Launchpad_Admin"
  group_name           = "wz_administrators"
  depends_on = [
    btp_subaccount_subscription.workzone
  ]
}

# Create a service instance for the workzone API
data "cloudfoundry_service_plan" "workzone_api_plan" {
  service_offering_name = "build-workzone-standard"
  name                  = "standard"
  depends_on            = [btp_subaccount_entitlement.workzone_api_entitlement]
}
resource "cloudfoundry_service_instance" "workzone_api" {
  name         = "workzone-api-cf"
  space        = cloudfoundry_space.wz_space.id
  service_plan = data.cloudfoundry_service_plan.workzone_api_plan.id
  type         = "managed"
  depends_on = [
    btp_subaccount_subscription.workzone
  ]
  timeouts = {
    create = "1h"
    delete = "1h"
    update = "1h"
  }
}
resource "cloudfoundry_service_credential_binding" "workzone_api_service_key" {
  type             = "key"
  name             = join("_", ["sk", "workzone", "api"])
  service_instance = cloudfoundry_service_instance.workzone_api.id
  depends_on = [
    cloudfoundry_service_instance.workzone_api
  ]
}

# Create a service instance for the task center.
data "cloudfoundry_service_plan" "task_center_plan" {
  service_offering_name = "one-inbox-service"
  name                  = "all-tasks"
  depends_on            = [btp_subaccount_entitlement.task_center_entitlement]
}
resource "cloudfoundry_service_instance" "task_center" {
  name         = "taskcenter-cf"
  space        = cloudfoundry_space.wz_space.id
  service_plan = data.cloudfoundry_service_plan.task_center_plan.id
  type         = "managed"
  depends_on = [
    btp_subaccount_subscription.workzone
  ]
  timeouts = {
    create = "1h"
    delete = "1h"
    update = "1h"
  }
}
resource "cloudfoundry_service_credential_binding" "task_center_service_key" {
  type             = "key"
  name             = join("_", ["sk", "task", "center"])
  service_instance = cloudfoundry_service_instance.task_center.id
  depends_on = [
    cloudfoundry_service_instance.task_center
  ]
}
