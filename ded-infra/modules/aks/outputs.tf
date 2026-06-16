output "aks_id"   { value = azurerm_kubernetes_cluster.aks.id }
output "aks_name" { value = azurerm_kubernetes_cluster.aks.name }
output "private_fqdn" { value = azurerm_kubernetes_cluster.aks.private_fqdn }
output "node_resource_group" { value = azurerm_kubernetes_cluster.aks.node_resource_group }

# ADD THESE TWO:
output "cluster_identity_principal_id" {
  description = "Principal ID of the AKS SystemAssigned identity (needs Network Contributor on VNet)"
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "kubelet_identity_object_id" {
  description = "Object ID of the kubelet identity (needs AcrPull on ACR)"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}