module "network" {
  source = "../../../modules/network"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  vnet_name = var.vnet_name
  vnet_cidr = var.vnet_cidr
  subnets   = var.subnets
  nsg_rules = var.nsg_rules
  enable_nat_gateway = true
}