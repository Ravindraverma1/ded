resource_group_name = "DED_Project"
location            = "westeurope"

tags = {
  env     = "dev"
  project = "ded"
  owner   = "DED"
}

vnet_name = "vnet-ded-dev-weu-01"
vnet_cidr = "10.60.0.0/16"

subnets = {
  "snet-aks-system"        = { cidr = "10.60.0.0/22" }
  "snet-aks-workload"      = { cidr = "10.60.8.0/21" }
  "snet-private-endpoints" = { cidr = "10.60.16.0/24" }
  "snet-apim"              = { cidr = "10.60.17.0/24" }
  "snet-dnspr-in"          = { cidr = "10.60.18.0/27" }
  "snet-dnspr-out"         = { cidr = "10.60.18.32/27" }
  "AzureBastionSubnet"     = { cidr = "10.60.19.0/26" }
  "snet-mgmt"                = { cidr = "10.60.19.64/27" }
}

nsg_rules = {

  # ── APIM Inbound — mandatory for VNet External mode ──────────
  "apim-inbound-management" = {
    name                       = "Allow-APIM-Management"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
    nsg_key                    = "snet-apim"
  }

  "apim-inbound-lb" = {
    name                       = "Allow-APIM-LoadBalancer"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "6390"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "VirtualNetwork"
    nsg_key                    = "snet-apim"
  }

  # ── APIM Outbound — mandatory for VNet External mode ─────────
  "apim-outbound-storage" = {
    name                       = "Allow-APIM-Storage"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Storage"
    nsg_key                    = "snet-apim"
  }

  "apim-outbound-sql" = {
    name                       = "Allow-APIM-SQL"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "1433"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Sql"
    nsg_key                    = "snet-apim"
  }

  "apim-outbound-keyvault" = {
    name                       = "Allow-APIM-KeyVault"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "AzureKeyVault"
    nsg_key                    = "snet-apim"
  }
}

enable_nat_gateway = true