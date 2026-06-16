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

module "aks" {
  source = "../../../modules/aks"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  aks_name   = var.aks_name
  sku_tier   = var.aks_tier
  dns_prefix = var.dns_prefix

  kubernetes_version = var.kubernetes_version

  system_subnet_id   = data.terraform_remote_state.network.outputs.subnet_ids["snet-aks-system"]
  workload_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["snet-aks-workload"]

  vm_size_system         = var.vm_size_system
  vm_size_api            = var.vm_size_api
  vm_size_worker         = var.vm_size_worker
  vm_size_integration    = var.vm_size_integration
  admin_group_object_ids = var.admin_group_object_ids
}