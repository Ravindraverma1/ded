variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "sql_server_name" {
  type = string
}

variable "sql_admin_username" {
  type = string
}

variable "sql_admin_password" {
  type      = string
  sensitive = true
}

variable "aad_admin_login" {
  type = string
}

variable "aad_admin_object_id" {
  type = string
}

variable "sql_db_name" {
  type = string
}

variable "sql_sku" {
  type    = string
  default = "GP_Gen5_8"
}

variable "sql_max_size_gb" {
  type    = number
  default = 500
}

variable "geo_backup_enabled" {
  type        = bool
  description = "Enable geo-redundant backups — disable for DEV to save cost"
  default     = false
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}

variable "sql_allowed_ips" {
  type = map(object({
    start_ip = string
    end_ip   = string
  }))
  default = {}
}

