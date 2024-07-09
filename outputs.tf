output "vm_name" {
  value = module.rgroup-N01660290.resource_group_name
}

output "subnet_name" {
  value = module.network-N01660290.subnet_name
}

output "log_analytics_workspace_name" {
  value = module.common-N01660290.log_analytics_workspace_name
}

output "recovery_services_vault_name" {
  value = module.common-N01660290.recovery_services_vault_name
}

output "storage_account_name" {
  value = module.common-N01660290.storage_account_name
}

output "storage_account_uri" {
  value = module.common-N01660290.storage_account_uri
}

output "vm_details_linux" {
  value = module.vmlinux-N01660290.vm_details
}

output "vm_details_windows" {
  description = "Details of the provisioned Windows VM."
  value = module.vmwindows-N01660290.vm_details
}
output "data_disk_ids" {
  description = "IDs of the provisioned data disks"
  value       = module.datadisk-N01660290.data_disk_ids
}

output "load_balancer_name" {
  description = "Name of the provisioned load balancer"
  value       = module.loadbalancer-N01660290.load_balancer_name
}
output "database_instance_name" {
  description = "Name of the provisioned PostgreSQL database instance."
  value       = module.database-N01660290.database_instance_name
}
