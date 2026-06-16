# Lookup existing private DNS zones by name (created in Phase 2.2)
data "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
}
data "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}
data "azurerm_private_dns_zone" "sb" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_group_name
}
data "azurerm_private_dns_zone" "acr" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
}

# Key Vault Private Endpoint
resource "azurerm_private_endpoint" "kv" {
  name                = "pe-kv-ded-dev-weu-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-kv-ded-dev-weu-01"
    private_connection_resource_id = var.key_vault_id
    subresource_names             = ["vault"]
    is_manual_connection          = false
  }

  private_dns_zone_group {
    name                 = "pdzg-kv"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.kv.id]
  }
}

# Storage (Blob) Private Endpoint
resource "azurerm_private_endpoint" "blob" {
  name                = "pe-stblob-ded-dev-weu-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-stblob-ded-dev-weu-01"
    private_connection_resource_id = var.storage_account_id
    subresource_names             = ["blob"]
    is_manual_connection          = false
  }

  private_dns_zone_group {
    name                 = "pdzg-blob"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.blob.id]
  }
}

# Service Bus Private Endpoint
resource "azurerm_private_endpoint" "sb" {
  count               = var.enable_sb_pe ? 1 : 0
  name                = "pe-sb-ded-dev-weu-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-sb-ded-dev-weu-01"
    private_connection_resource_id = var.servicebus_namespace_id
    subresource_names             = ["namespace"]
    is_manual_connection          = false
  }

  private_dns_zone_group {
    name                 = "pdzg-sb"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.sb.id]
  }
}

# ACR Private Endpoint
resource "azurerm_private_endpoint" "acr" {
  count               = var.enable_acr_pe ? 1 : 0
  name                = "pe-acr-ded-dev-weu-01"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "psc-acr-ded-dev-weu-01"
    private_connection_resource_id = var.acr_id
    subresource_names             = ["registry"]
    is_manual_connection          = false
  }

  private_dns_zone_group {
    name                 = "pdzg-acr"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.acr.id]
  }
}