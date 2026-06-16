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

module "bastion_mgmt" {
  source              = "../../../modules/bastion_mgmt"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  bastion_name      = "bas-ded-dev-weu-01"
  bastion_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["AzureBastionSubnet"]

  vm_name      = "vm-mgmt-ded-dev-weu-01"
  vm_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["snet-mgmt"]

  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key

  vm_size         = "Standard_D4ds_v5"
  os_disk_size_gb = 250  
}