output "zone_ids" {
  value = { for k, z in azurerm_private_dns_zone.zone : k => z.id }
}