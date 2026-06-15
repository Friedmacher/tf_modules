variable "cf_org_id" {
  description = "ID of the Cloud Foundry organization."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+$", var.cf_org_id))
    error_message = "cf_org_id must be a valid Cloud Foundry organization ID."
  }
}

variable "cf_space_name" {
  description = "Name of the Cloud Foundry space to be created."
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+$", var.cf_space_name))
    error_message = "cf_space_name must be a valid Cloud Foundry space name."
  }
}
