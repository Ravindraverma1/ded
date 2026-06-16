output "vm_id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "vm_name" {
  value = azurerm_windows_virtual_machine.vm.name
}

output "private_ip" {
  description = "Private IP address — used to identify VM in Bastion"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}