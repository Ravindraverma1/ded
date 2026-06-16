variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

variable "vnet_name" { type = string }
variable "vnet_cidr" { type = string }

variable "subnets" {
  type = map(object({ cidr = string }))
}

variable "nsg_rules" {
  description = "Map of NSG rules to create across any subnet NSG"
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    nsg_key                    = string  # must match a key in var.subnets
  }))
  default = {}
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable NAT Gateway for static outbound IP"
  default     = false
}