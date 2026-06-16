output "bastion_id"        { value = azurerm_bastion_host.bastion.id }
output "bastion_name"      { value = azurerm_bastion_host.bastion.name }
output "bastion_public_ip" { value = azurerm_public_ip.bastion_pip.ip_address }

output "vm_id"        { value = azurerm_linux_virtual_machine.vm.id }
output "vm_name"      { value = azurerm_linux_virtual_machine.vm.name }
output "vm_private_ip" {
  value = azurerm_network_interface.vm_nic.ip_configuration[0].private_ip_address
}