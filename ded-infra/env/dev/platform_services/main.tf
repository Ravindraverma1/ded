module "platform_services" {
  source = "../../../modules/platform_services"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  key_vault_name        = var.key_vault_name
  storage_account_name  = var.storage_account_name
  servicebus_name       = var.servicebus_name
  acr_name              = var.acr_name
}