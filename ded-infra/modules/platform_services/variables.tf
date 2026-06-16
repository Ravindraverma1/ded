variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

variable "key_vault_name" { type = string }
variable "storage_account_name" { type = string }
variable "servicebus_name" { type = string }
variable "acr_name" { type = string }