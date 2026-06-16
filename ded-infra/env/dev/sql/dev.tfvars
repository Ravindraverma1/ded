resource_group_name = "DED_Project"
location            = "westeurope"

tags = {
  env       = "dev"
  project   = "ded"
  owner     = "DED"
}

sql_server_name    = "sql-ded-dev-weu-01"
sql_admin_username = "sqladmin"
#sql_admin_password = "CHANGE_ME_Str0ng!Pass"

aad_admin_login     = "DED-Admins"
aad_admin_object_id = "cd5ddd2a-092c-4d04-81f4-86133404fbab"

sql_db_name     = "sqldb-ded-dev-weu-01"
sql_sku         = "GP_Gen5_8"
sql_max_size_gb = 500
geo_backup_enabled = true
public_network_access_enabled = true # make it false in QA,stag,prod

sql_allowed_ips = {
  "allow-all" = { start_ip = "0.0.0.0", end_ip = "255.255.255.254" }
}