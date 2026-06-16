data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = "DED_Project"
    storage_account_name = "sttfdeddevweuee71"
    container_name       = "tfstate"
    key                  = "ded-dev.network.tfstate"
    use_azuread_auth     = true
  }
}

data "terraform_remote_state" "dns" {
  backend = "azurerm"
  config = {
    resource_group_name  = "DED_Project"
    storage_account_name = "sttfdeddevweuee71"
    container_name       = "tfstate"
    key                  = "ded-dev.dns.tfstate"
    use_azuread_auth     = true
  }
}

module "sql" {
  source = "../../../modules/sql"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  sql_server_name    = var.sql_server_name
  sql_admin_username = var.sql_admin_username
  sql_admin_password = var.sql_admin_password

  aad_admin_login     = var.aad_admin_login
  aad_admin_object_id = var.aad_admin_object_id

  sql_db_name     = var.sql_db_name
  sql_sku         = var.sql_sku
  sql_max_size_gb = var.sql_max_size_gb

  private_endpoints_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["snet-private-endpoints"]
  sql_private_dns_zone_id     = data.terraform_remote_state.dns.outputs.zone_ids["privatelink.database.windows.net"]
  public_network_access_enabled = var.public_network_access_enabled
  sql_allowed_ips               = var.sql_allowed_ips
}