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

module "apim" {
  source = "../../../modules/apim"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  apim_name       = var.apim_name
  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email

  apim_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["snet-apim"]
}