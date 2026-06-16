data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  public_network_access_enabled = false

  purge_protection_enabled    = false  # DEV-friendly; STG/PROD usually true
  soft_delete_retention_days  = 7

  tags = var.tags
}

resource "azurerm_storage_account" "st" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  allow_nested_items_to_be_public = false
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_servicebus_namespace" "sb" {
  name                = var.servicebus_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  public_network_access_enabled = true # this is changed to true allow public  because private endpoints will not be created for service bus [pv endpoints for service bus tier should be premium high cost]

  tags = var.tags
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = false

  public_network_access_enabled = true  # this is changed to true because false only allowed for preimum tier higher cost 

  tags = var.tags
}