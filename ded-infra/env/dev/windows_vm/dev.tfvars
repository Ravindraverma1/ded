resource_group_name = "DED_Project"
location            = "westeurope"

tags = {
  env       = "dev"
  project   = "ded"
  owner     = "DED"
}

vm_name         = "vm-dev-ded-dev-weu-01"
computer_name   = "dev-ded-win"            # max 15 chars
vm_size         = "Standard_D2ds_v5"
admin_username  = "dedadmin"
os_disk_size_gb = 128