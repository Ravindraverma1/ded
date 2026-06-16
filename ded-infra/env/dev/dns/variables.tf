variable "resource_group_name" { type = string }
variable "tags" { type = map(string) }

# optional override if needed later
variable "private_dns_zones" {
  type    = set(string)
  default = []
}