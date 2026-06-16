data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = "DED_Project"
    storage_account_name = "sttfdeddevweuee71"
    container_name       = "tfstate"
    key                  = "ded-dev.network.tfstate"
    use_azuread_auth     = true
  }
}

data "terraform_remote_state" "platform" {
  backend = "azurerm"
  config = {
    resource_group_name  = "DED_Project"
    storage_account_name = "sttfdeddevweuee71"
    container_name       = "tfstate"
    key                  = "ded-dev.platform.tfstate"
    use_azuread_auth     = true
  }
}

module "private_endpoints" {
  source = "../../../modules/private_endpoints"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  private_endpoint_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["snet-private-endpoints"]

  key_vault_id            = data.terraform_remote_state.platform.outputs.key_vault_id
  storage_account_id      = data.terraform_remote_state.platform.outputs.storage_account_id
  servicebus_namespace_id = data.terraform_remote_state.platform.outputs.servicebus_namespace_id
  acr_id                  = data.terraform_remote_state.platform.outputs.acr_id
  enable_acr_pe           = false
  enable_sb_pe            = false
}