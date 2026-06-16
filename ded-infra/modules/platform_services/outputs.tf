output "key_vault_id" { value = azurerm_key_vault.kv.id }
output "storage_account_id" { value = azurerm_storage_account.st.id }
output "servicebus_namespace_id" { value = azurerm_servicebus_namespace.sb.id }
output "acr_id" { value = azurerm_container_registry.acr.id }

output "key_vault_name" { value = azurerm_key_vault.kv.name }
output "storage_account_name" { value = azurerm_storage_account.st.name }
output "servicebus_name" { value = azurerm_servicebus_namespace.sb.name }
output "acr_name" { value = azurerm_container_registry.acr.name }