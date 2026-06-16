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

module "ai_stack" {
  source = "../../../modules/ai_stack"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  # OpenAI
  openai_name        = var.openai_name
  gpt4o_version      = var.gpt4o_version
  gpt4o_capacity     = var.gpt4o_capacity
  embedding_version  = var.embedding_version
  embedding_capacity = var.embedding_capacity

  # AI Search
  search_name = var.search_name
  search_sku  = var.search_sku

  # Functions
  func_name           = var.func_name
  func_storage_name   = var.func_storage_name
  func_python_version = var.func_python_version

  # Networking — from network remote state
  private_endpoints_subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["snet-private-endpoints"]

  # Private DNS zones — from dns remote state
  openai_private_dns_zone_id = data.terraform_remote_state.dns.outputs.zone_ids["privatelink.openai.azure.com"]
  search_private_dns_zone_id = data.terraform_remote_state.dns.outputs.zone_ids["privatelink.search.windows.net"]
}