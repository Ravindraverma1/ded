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

module "dns" {
  source              = "../../../modules/dns"
  resource_group_name = var.resource_group_name
  tags                = var.tags
  vnet_id             = data.terraform_remote_state.network.outputs.vnet_id

  private_dns_zones = var.private_dns_zones
}