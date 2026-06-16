output "sql_server_id" {
  value = azurerm_mssql_server.sql.id
}

output "sql_server_name" {
  value = azurerm_mssql_server.sql.name
}

output "sql_server_fqdn" {
  description = "SQL Server fully qualified domain name"
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
}

output "sql_db_name" {
  value = azurerm_mssql_database.db.name
}

output "sql_server_principal_id" {
  description = "SQL Server system-assigned identity principal ID"
  value       = azurerm_mssql_server.sql.identity[0].principal_id
}

output "private_endpoint_ip" {
  description = "Private endpoint IP — use this to connect from AKS/VM"
  value       = azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address
}