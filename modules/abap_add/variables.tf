variable "subaccount_id" {
  description = "ID of the subaccount to be trusted."
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.subaccount_id))
    error_message = "subaccount_id must be a valid UUID."
  }
}

variable "cf_space_id" {
  description = "The ID of the Cloud Foundry space where the ABAP system will be deployed."
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.cf_space_id))
    error_message = "cf_space_id must be a valid UUID."
  }
}

variable "abap_sid" {
  type        = string
  description = "The system ID (SID) of the ABAP system."
  validation {
    condition     = can(regex("^[A-Z][A-Z0-9]{2}$", var.abap_sid))
    error_message = "Please provide a valid system ID (SID). It must consist of exactly three alphanumeric characters. Only uppercase letters are allowed. The first character must be a letter (not a digit). The ID does not have to be technically unique."
  }
  default = "A01"
}

variable "abap_admin_email" {
  description = "The email address of the ABAP system administrator."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.abap_admin_email))
    error_message = "Please provide a valid email address for the ABAP system administrator."
  }
}

variable "abap_is_development_allowed" {
  description = "Flag indicating whether development is allowed on the ABAP system."
  type        = bool
  default     = true
}
