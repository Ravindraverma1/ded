output "vnet_id"    { value = azurerm_virtual_network.vnet.id }
output "vnet_name"  { value = azurerm_virtual_network.vnet.name }
output "subnet_ids" { value = { for k, s in azurerm_subnet.subnets : k => s.id } }
output "nat_public_ip" {
  value = var.enable_nat_gateway ? azurerm_public_ip.nat_pip[0].ip_address : null
}