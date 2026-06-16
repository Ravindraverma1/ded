output "key_vault_id" { value = module.platform_services.key_vault_id }
output "storage_account_id" { value = module.platform_services.storage_account_id }
output "servicebus_namespace_id" { value = module.platform_services.servicebus_namespace_id }
output "acr_id" { value = module.platform_services.acr_id }

output "key_vault_name" { value = module.platform_services.key_vault_name }
output "storage_account_name" { value = module.platform_services.storage_account_name }
output "servicebus_name" { value = module.platform_services.servicebus_name }
output "acr_name" { value = module.platform_services.acr_name }