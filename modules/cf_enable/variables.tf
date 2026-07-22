variable "subaccount_id" {
  description = "ID of the subaccount to be trusted."
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.subaccount_id))
    error_message = "subaccount_id must be a valid UUID."
  }
}

variable "subaccount_subdomain" {
  description = "Subdomain of the subaccount to be trusted."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.subaccount_subdomain))
    error_message = "subaccount_subdomain must be a valid subdomain name."
  }
}

variable "cf_region" {
  description = "Region where the cloud foundry instance shall be created in."
  type        = string
  validation {
    condition     = contains(["cf-eu10-005"], var.cf_region)
    error_message = "The region of the subaccount must be one of: cf-eu10-005."
  }
}

variable "user_name" {
  description = "Name of the user to be added to the Cloud Foundry org."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.user_name))
    error_message = "user_name must be a valid email address."
  }
}

variable "idp_origin" {
  description = "Identity provider origin of the user to be added to the Cloud Foundry org."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+$", var.idp_origin))
    error_message = "idp_origin must be a valid identity provider origin."
  }
}

