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

module "windows_vm" {
  source = "../../../modules/windows_vm"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  vm_name        = var.vm_name
  computer_name  = var.computer_name        # add this line
  vm_size        = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password
  os_disk_size_gb = var.os_disk_size_gb

  # Reuse snet-mgmt — same subnet as Ubuntu VM
  vm_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["snet-mgmt"]
}