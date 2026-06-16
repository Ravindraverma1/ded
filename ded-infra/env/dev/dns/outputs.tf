output "zone_ids" {
  value = module.dns.zone_ids
}

output "zone_names" {
  value = keys(module.dns.zone_ids)
}