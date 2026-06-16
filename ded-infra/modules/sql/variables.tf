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
  type        = string
  description = "Azure SQL Server name (must be globally unique)"
}

variable "sql_admin_username" {
  type        = string
  description = "SQL Server local administrator username"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Server local administrator password"
  sensitive   = true
}

variable "aad_admin_login" {
  type        = string
  description = "Azure AD admin display name (user or group)"
}

variable "aad_admin_object_id" {
  type        = string
  description = "Azure AD admin object ID"
}

variable "sql_db_name" {
  type        = string
  description = "SQL Database name"
}

variable "sql_sku" {
  type        = string
  description = "SQL Database SKU — GP_Gen5_8 = General Purpose 8 vCores"
  default     = "GP_Gen5_8"
}

variable "sql_max_size_gb" {
  type        = number
  description = "Maximum database size in GB"
  default     = 500
}

variable "private_endpoints_subnet_id" {
  type        = string
  description = "Subnet ID for private endpoint (snet-private-endpoints)"
}

variable "sql_private_dns_zone_id" {
  type        = string
  description = "Private DNS zone ID for privatelink.database.windows.net"
}

variable "geo_backup_enabled" {
  type        = bool
  description = "Enable geo-redundant backups — disable for DEV to save cost"
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access to SQL Server"
  default     = false
}

variable "sql_allowed_ips" {
  description = "Map of firewall rules for public SQL access"
  type = map(object({
    start_ip = string
    end_ip   = string
  }))
  default = {}
}