variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

variable "admin_username" { type = string }
variable "ssh_public_key" { type = string }