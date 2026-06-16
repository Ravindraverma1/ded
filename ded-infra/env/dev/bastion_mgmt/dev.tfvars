resource_group_name = "DED_Project"
location            = "westeurope"

tags = {
  env       = "dev"
  project   = "ded"
  owner     = "DED"
}

admin_username = "azureuser"
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIESvKhrr0pFIISAGm1B27UeR4SKA6zsCbuYqIhuRau+w ded-dev-bastion"