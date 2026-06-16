resource_group_name = "DED_Project"
location            = "westeurope"

tags = {
  env     = "dev"
  project = "ded"
  owner   = "DED"
}

aks_name           = "aks-ded-dev-weu-01"
dns_prefix         = "aks-ded-dev"
aks_tier           = "Free"
kubernetes_version = "1.34" # example; adjust to your allowed version

vm_size_system      = "Standard_D2s_v5"
vm_size_api         = "Standard_D4s_v5"
vm_size_worker      = "Standard_D2s_v5"
vm_size_integration = "Standard_D2s_v5"

admin_group_object_ids = ["cd5ddd2a-092c-4d04-81f4-86133404fbab"]
ops_group_object_id    = "5da58793-ec4a-4b62-be70-ec4d36e4b82d"
dev_group_object_id    = "f451e33a-d90d-4430-8f9c-4ea5d2dfc5d8"