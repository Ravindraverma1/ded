terraform {
  backend "azurerm" {
    resource_group_name  = "DED_Project"
    storage_account_name = "sttfdeddevweuee71"
    container_name       = "tfstate"
    key                  = "ded-dev.apim.tfstate"
    use_azuread_auth     = true
  }
}