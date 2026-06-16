# Wait for OpenAI account to finish provisioning before creating private endpoint
resource "time_sleep" "openai_provisioning" {
  depends_on      = [azurerm_cognitive_account.openai]
  create_duration = "60s"
}


# ──────────────────────────────────────────────
# Azure OpenAI
# ──────────────────────────────────────────────
resource "azurerm_cognitive_account" "openai" {
  name                          = var.openai_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = "OpenAI"
  sku_name                      = "S0"
  custom_subdomain_name         = var.openai_name   # required for private endpoint
  public_network_access_enabled = false

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_cognitive_deployment" "gpt4o" {
  name                 = "gpt-4o"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "gpt-4o"
    version = var.gpt4o_version
  }

  sku {
    name     = "GlobalStandard"
    capacity = var.gpt4o_capacity
  }
}

resource "azurerm_cognitive_deployment" "embedding" {
  name                 = "text-embedding-3-large"
  cognitive_account_id = azurerm_cognitive_account.openai.id

  model {
    format  = "OpenAI"
    name    = "text-embedding-3-large"
    version = var.embedding_version
  }

  sku {
    name     = "GlobalStandard"
    capacity = var.embedding_capacity
  }
}

# ──────────────────────────────────────────────
# Private Endpoint — OpenAI
# ──────────────────────────────────────────────
resource "azurerm_private_endpoint" "openai" {
  name                = "pe-${var.openai_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "psc-${var.openai_name}"
    private_connection_resource_id = azurerm_cognitive_account.openai.id
    subresource_names              = ["account"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dzg-openai"
    private_dns_zone_ids = [var.openai_private_dns_zone_id]
  }

  tags = var.tags
}

# ──────────────────────────────────────────────
# Azure AI Search (VectorDB)
# ──────────────────────────────────────────────
resource "azurerm_search_service" "search" {
  name                          = var.search_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.search_sku
  replica_count                 = 1
  partition_count               = 1
  public_network_access_enabled = false

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# ──────────────────────────────────────────────
# Private Endpoint — AI Search
# ──────────────────────────────────────────────
resource "azurerm_private_endpoint" "search" {
  name                = "pe-${var.search_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoints_subnet_id

  private_service_connection {
    name                           = "psc-${var.search_name}"
    private_connection_resource_id = azurerm_search_service.search.id
    subresource_names              = ["searchService"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dzg-search"
    private_dns_zone_ids = [var.search_private_dns_zone_id]
  }

  tags = var.tags
}

# ──────────────────────────────────────────────
# Storage Account — required by Azure Functions
# ──────────────────────────────────────────────
resource "azurerm_storage_account" "func" {
  name                     = var.func_storage_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = var.tags
}

# ──────────────────────────────────────────────
# App Service Plan — Consumption (serverless)
# ──────────────────────────────────────────────
resource "azurerm_service_plan" "func" {
  name                = "asp-${var.func_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "Y1"

  tags = var.tags
}

# ──────────────────────────────────────────────
# Azure Function App
# ──────────────────────────────────────────────
resource "azurerm_linux_function_app" "func" {
  name                       = var.func_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.func.id
  storage_account_name       = azurerm_storage_account.func.name
  storage_account_access_key = azurerm_storage_account.func.primary_access_key

  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      python_version = var.func_python_version
    }
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "python"
    AZURE_OPENAI_ENDPOINT    = azurerm_cognitive_account.openai.endpoint
    AZURE_SEARCH_ENDPOINT    = "https://${azurerm_search_service.search.name}.search.windows.net"
  }

  tags = var.tags
}

# ──────────────────────────────────────────────
# RBAC — Function App → OpenAI
# ──────────────────────────────────────────────
resource "azurerm_role_assignment" "func_openai" {
  scope                = azurerm_cognitive_account.openai.id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = azurerm_linux_function_app.func.identity[0].principal_id
}

# ──────────────────────────────────────────────
# RBAC — Function App → AI Search
# ──────────────────────────────────────────────
resource "azurerm_role_assignment" "func_search" {
  scope                = azurerm_search_service.search.id
  role_definition_name = "Search Index Data Contributor"
  principal_id         = azurerm_linux_function_app.func.identity[0].principal_id
}

# ──────────────────────────────────────────────
# RBAC — AI Search → OpenAI (indexer calls embeddings)
# ──────────────────────────────────────────────
resource "azurerm_role_assignment" "search_openai" {
  scope                = azurerm_cognitive_account.openai.id
  role_definition_name = "Cognitive Services OpenAI User"
  principal_id         = azurerm_search_service.search.identity[0].principal_id
}