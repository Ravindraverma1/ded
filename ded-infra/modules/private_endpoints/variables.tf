variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

variable "private_endpoint_subnet_id" { type = string }

variable "key_vault_id" { type = string }
variable "storage_account_id" { type = string }
variable "servicebus_namespace_id" { type = string }
variable "acr_id" { type = string }

variable "enable_acr_pe" {
  type    = bool
  default = true
}

variable "enable_sb_pe" {
  type    = bool
  default = true
}