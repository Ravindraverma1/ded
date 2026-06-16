output "rg_name"   { value = azurerm_resource_group.rg.name }
output "location"  { value = azurerm_resource_group.rg.location }
output "law_id"    { value = azurerm_log_analytics_workspace.law.id }
output "law_name"  { value = azurerm_log_analytics_workspace.law.name }