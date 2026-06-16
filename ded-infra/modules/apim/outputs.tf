output "apim_id"          { value = azurerm_api_management.apim.id }
output "apim_name"        { value = azurerm_api_management.apim.name }
output "apim_gateway_url" { value = azurerm_api_management.apim.gateway_url }
output "apim_public_ip"   { value = azurerm_api_management.apim.public_ip_addresses }

output "apim_identity_principal_id" {
  description = "APIM system-assigned identity principal ID — used for Key Vault access"
  value       = azurerm_api_management.apim.identity[0].principal_id
}