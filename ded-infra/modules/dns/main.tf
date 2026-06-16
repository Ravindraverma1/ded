locals {
  default_zones = toset([
    "privatelink.vaultcore.azure.net",
    "privatelink.blob.core.windows.net",
    "privatelink.servicebus.windows.net",
    "privatelink.azurecr.io",
    "privatelink.search.windows.net",
    "privatelink.openai.azure.com", # added for Azure OpenAI
    "privatelink.database.windows.net",       
  ])

  zones = length(var.private_dns_zones) > 0 ? var.private_dns_zones : local.default_zones
}

resource "azurerm_private_dns_zone" "zone" {
  for_each            = local.zones
  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each              = local.zones
  name                  = "link-${replace(each.value, ".", "-")}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.zone[each.value].name
  virtual_network_id    = var.vnet_id
  registration_enabled  = false
}