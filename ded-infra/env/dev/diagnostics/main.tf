data "terraform_remote_state" "foundation" {
  backend = "azurerm"
  config = {
    resource_group_name  = "DED_Project"
    storage_account_name = "sttfdeddevweuee71"
    container_name       = "tfstate"
    key                  = "ded-dev.foundation.tfstate"
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

locals {
  # NOTE: Storage diagnostics are applied at the *service* level (blobServices/default)
  storage_blob_service_id = "${data.terraform_remote_state.platform.outputs.storage_account_id}/blobServices/default"

  targets = {
    keyvault    = data.terraform_remote_state.platform.outputs.key_vault_id
    storageblob = local.storage_blob_service_id
    servicebus  = data.terraform_remote_state.platform.outputs.servicebus_namespace_id
    acr         = data.terraform_remote_state.platform.outputs.acr_id
  }
}

module "diagnostics" {
  source  = "../../../modules/diagnostics"
  law_id  = data.terraform_remote_state.foundation.outputs.law_id
  targets = local.targets
}