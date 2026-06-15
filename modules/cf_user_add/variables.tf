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

variable "cf_org_id" {
  description = "ID of the Cloud Foundry organization."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+$", var.cf_org_id))
    error_message = "cf_org_id must be a valid Cloud Foundry organization ID."
  }
}

variable "cf_space_id" {
  description = "ID of the Cloud Foundry space."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+$", var.cf_space_id))
    error_message = "cf_space_id must be a valid Cloud Foundry space ID."
  }
}
