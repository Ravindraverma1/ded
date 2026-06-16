output "aks_id" { value = module.aks.aks_id }
output "aks_name" { value = module.aks.aks_name }
output "private_fqdn" { value = module.aks.private_fqdn }
output "node_resource_group" { value = module.aks.node_resource_group }

# ADD THESE:
output "cluster_identity_principal_id" {
  value = module.aks.cluster_identity_principal_id
}
output "kubelet_identity_object_id" {
  value = module.aks.kubelet_identity_object_id
}