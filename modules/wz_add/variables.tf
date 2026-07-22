variable "subaccount_id" {
  description = "ID of the subaccount to be trusted."
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.subaccount_id))
    error_message = "subaccount_id must be a valid UUID."
  }
}

variable "btp_platform_idp" {
  description = "FQDN of the Platform Identity Provider."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.btp_platform_idp))
    error_message = "btp_platform_idp must be a valid FQDN."
  }
}

variable "cf_org_id" {
  description = "ID of the Cloud Foundry organization."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+$", var.cf_org_id))
    error_message = "cf_org_id must be a valid Cloud Foundry organization ID."
  }
}
