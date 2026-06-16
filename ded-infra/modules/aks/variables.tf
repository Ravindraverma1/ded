variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

variable "aks_name" { type = string }
variable "dns_prefix" { type = string }
variable "sku_tier" { type = string }

variable "system_subnet_id" { type = string }
variable "workload_subnet_id" { type = string }

variable "kubernetes_version" { type = string }

variable "vm_size_system" { type = string }
variable "vm_size_api" { type = string }
variable "vm_size_worker" { type = string }
variable "vm_size_integration" { type = string }

variable "admin_group_object_ids" {
  type = list(string)
}

variable "azure_rbac_enabled" {
  type    = bool
  default = true
}

