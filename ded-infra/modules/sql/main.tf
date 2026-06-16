# ──────────────────────────────────────────────
# Azure SQL Server
# ──────────────────────────────────────────────
resource "azurerm_mssql_server" "sql" {
  name                          = var.sql_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = var.sql_admin_username
  administrator_login_password  = var.sql_admin_password
  minimum_tls_version           = "1.2"
  public_network_access_enabled = var.public_network_access_enabled

  azuread_administrator {
    login_username              = var.aad_admin_login
    object_id                   = var.aad_admin_object_id
    azuread_authentication_only = false
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# ──────────────────────────────────────────────
# Azure SQL Database — General Purpose 8 vCores
# ──────────────────────────────────────────────
resource "azurerm_mssql_database" "db" {
  name           = var.sql_db_name
  server_id      = azurerm_mssql_server.sql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = var.sql_sku
  max_size_gb    = var.sql_max_size_gb
  zone_redundant = false
  geo_backup_enabled = var.geo_backup_enabled

  tags = var.tags
}

# ──────────────────────────────────────────────
# Private Endpoint — SQL Server
# ──────────────────────────────────────────────
resource "azurerm_private_endpoint" "sql" {
  name                = "pe-${var.sql_server_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "psc-${var.sql_server_name}"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dzg-sql"
    private_dns_zone_ids = [var.sql_private_dns_zone_id]
  }

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "allowed_ips" {
  for_each = var.sql_allowed_ips

  name             = each.key
  server_id        = azurerm_mssql_server.sql.id
  start_ip_address = each.value.start_ip
  end_ip_address   = each.value.end_ip
}