resource "azurerm_role_assignment" "aks_admin" {
  scope                = module.aks.aks_id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = var.admin_group_object_ids[0]
}

resource "azurerm_role_assignment" "aks_ops" {
  scope                = module.aks.aks_id
  role_definition_name = "Azure Kubernetes Service RBAC Admin"
  principal_id         = var.ops_group_object_id
}

resource "azurerm_role_assignment" "aks_dev" {
  scope                = module.aks.aks_id
  role_definition_name = "Azure Kubernetes Service RBAC Writer"
  principal_id         = var.dev_group_object_id
}

# ADD THIS — fixes the 403 SyncLoadBalancerFailed error
# AKS SystemAssigned identity must be able to read/write subnets
# to provision Load Balancers in the VNet
resource "azurerm_role_assignment" "aks_identity_network_contributor" {
  scope = data.terraform_remote_state.network.outputs.vnet_id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.cluster_identity_principal_id
}