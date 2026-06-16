output "openai_id" {
  value = azurerm_cognitive_account.openai.id
}

output "openai_endpoint" {
  value = azurerm_cognitive_account.openai.endpoint
}

output "openai_principal_id" {
  value = azurerm_cognitive_account.openai.identity[0].principal_id
}

output "search_id" {
  value = azurerm_search_service.search.id
}

output "search_name" {
  value = azurerm_search_service.search.name
}

output "search_principal_id" {
  value = azurerm_search_service.search.identity[0].principal_id
}

output "func_id" {
  value = azurerm_linux_function_app.func.id
}

output "func_name" {
  value = azurerm_linux_function_app.func.name
}

output "func_default_hostname" {
  value = azurerm_linux_function_app.func.default_hostname
}

output "func_principal_id" {
  value = azurerm_linux_function_app.func.identity[0].principal_id
}