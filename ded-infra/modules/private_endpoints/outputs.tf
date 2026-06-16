output "private_endpoint_ids" {
  value = {
    key_vault  = azurerm_private_endpoint.kv.id
    blob       = azurerm_private_endpoint.blob.id
    servicebus = var.enable_sb_pe ? azurerm_private_endpoint.sb[0].id : null
    acr        = var.enable_acr_pe ? azurerm_private_endpoint.acr[0].id : null
  }
}