output "abap_dashboard_url" {
  value       = cloudfoundry_service_instance.abap_env.dashboard_url
  description = "The URL of the ABAP service instance dashboard."
}

output "abap_service_key" {
  value       = btp_subaccount_service_binding.abap_binding.credentials
  description = "The credentials of the ABAP service instance."
  sensitive   = true
}
