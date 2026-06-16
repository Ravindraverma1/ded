variable "resource_group_name" { type = string }
variable "tags" { type = map(string) }
variable "vnet_id" { type = string }

# optional: allow override/extension later (OpenAI etc.)
variable "private_dns_zones" {
  type    = set(string)
  default = []
}