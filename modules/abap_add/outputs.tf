output "abap_dashboard_url" {
  value       = cloudfoundry_service_instance.abap_system.dashboard_url
  description = "The URL of the ABAP service instance dashboard."
}
