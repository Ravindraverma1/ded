output "bastion_name"      { value = module.bastion_mgmt.bastion_name }
output "bastion_public_ip" { value = module.bastion_mgmt.bastion_public_ip }
output "vm_name"           { value = module.bastion_mgmt.vm_name }
output "vm_private_ip"     { value = module.bastion_mgmt.vm_private_ip }