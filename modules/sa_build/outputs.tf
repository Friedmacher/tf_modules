output "subaccount_id" {
  value       = btp_subaccount.subaccount.id
  description = "Technical ID of the subaccount."
}

output "subaccount_name" {
  value       = btp_subaccount.subaccount.name
  description = "Display name of the subaccount."
}

output "subaccount_subdomain" {
  value       = btp_subaccount.subaccount.subdomain
  description = "Subdomain of the subaccount."
}
