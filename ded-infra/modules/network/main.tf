resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
  tags                = var.tags
}

resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.cidr]

  # Required for Private Endpoints subnet
  private_endpoint_network_policies = each.key == "snet-private-endpoints" ? "Disabled" : "Enabled"
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.subnets
  name                = "nsg-${each.key}-${var.tags.env}-${var.tags.project}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "rules" {
  for_each = var.nsg_rules

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = "*"
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.nsg_key].name
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each = {
    for k, v in var.subnets : k => v
    if k != "AzureBastionSubnet"
  }

  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

resource "azurerm_public_ip" "nat_pip" {
  count               = var.enable_nat_gateway ? 1 : 0
  name                = "pip-nat-${var.vnet_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# NAT Gateway — static outbound IP for client firewall whitelistin
resource "azurerm_nat_gateway" "nat" {
  count               = var.enable_nat_gateway ? 1 : 0
  name                = "nat-${var.vnet_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip" {
  count                = var.enable_nat_gateway ? 1 : 0
  nat_gateway_id       = azurerm_nat_gateway.nat[0].id
  public_ip_address_id = azurerm_public_ip.nat_pip[0].id
}

resource "azurerm_subnet_nat_gateway_association" "mgmt" {
  count          = var.enable_nat_gateway ? 1 : 0
  subnet_id      = azurerm_subnet.subnets["snet-mgmt"].id
  nat_gateway_id = azurerm_nat_gateway.nat[0].id
}