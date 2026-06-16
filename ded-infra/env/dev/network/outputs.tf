output "vnet_id" {
  value = module.network.vnet_id
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "nat_public_ip" {
  description = "Static outbound NAT IP — share with client"
  value       = module.network.nat_public_ip
}