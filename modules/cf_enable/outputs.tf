output "cf_instance_id" {
  value       = btp_subaccount_environment_instance.cloudfoundry.id
  description = "Technical ID of the Cloud Foundry instance."
}

output "cf_org_id" {
  value       = btp_subaccount_environment_instance.cloudfoundry.platform_id
  description = "Technical ID of the Cloud Foundry organization."
}
