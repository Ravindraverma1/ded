resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  sku_tier            = var.sku_tier

  kubernetes_version  = var.kubernetes_version

  role_based_access_control_enabled = true

azure_active_directory_role_based_access_control {
  azure_rbac_enabled     = true
  admin_group_object_ids = var.admin_group_object_ids
}

  oidc_issuer_enabled = true
  workload_identity_enabled = true

  private_cluster_enabled = true

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    
    name           = "system"
    vm_size        = var.vm_size_system
    node_count     = 1
    vnet_subnet_id = var.system_subnet_id
    type           = "VirtualMachineScaleSets"
    # system pool best practice
    only_critical_addons_enabled = true
    upgrade_settings {
    max_surge       = "1"
  }
    
  }

  network_profile {
    network_plugin = "azure"
    # keep simple defaults now; we’ll tune later if needed
  }

  tags = var.tags
}

# API pool
resource "azurerm_kubernetes_cluster_node_pool" "api" {
  name                  = "api"
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.vm_size_api
  node_count            = 1
  vnet_subnet_id        = var.workload_subnet_id
  mode                  = "User"
  tags                  = var.tags
  upgrade_settings {
  max_surge = "1"
}
}

# Worker pool
resource "azurerm_kubernetes_cluster_node_pool" "worker" {
  name                  = "worker"
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.vm_size_worker
  node_count            = 1
  vnet_subnet_id        = var.workload_subnet_id
  mode                  = "User"
  tags                  = var.tags
  upgrade_settings {
  max_surge = "1"
}
}

# Integration pool
resource "azurerm_kubernetes_cluster_node_pool" "integration" {
  name                  = "integ"
  kubernetes_cluster_id  = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.vm_size_integration
  node_count            = 1
  vnet_subnet_id        = var.workload_subnet_id
  mode                  = "User"
  tags                  = var.tags
  upgrade_settings {
  max_surge = "1" # Even if the pool creates, AKS upgrades can temporarily need extra vCPU for “surge” nodes. Since your remaining quota is tight, set max_surge = 0 on all pools to avoid needing extra vCPUs during upgrades

}
}