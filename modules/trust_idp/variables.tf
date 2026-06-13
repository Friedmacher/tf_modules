variable "subaccount_id" {
  description = "ID of the subaccount to be trusted."
  type        = string
  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.subaccount_id))
    error_message = "subaccount_id must be a valid UUID."
  }
}

variable "idp_host" {
  description = "Host of the Identity Provider (IdP) to be trusted."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+$", var.idp_host))
    error_message = "idp_host must be a valid hostname."
  }
}
