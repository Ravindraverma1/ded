resource_group_name = "DED_Project"
location            = "westeurope"

tags = {
  env       = "dev"
  project   = "ded"
  owner     = "DED"
}

key_vault_name       = "kv-ded-dev-weu-01"
servicebus_name      = "sb-ded-dev-weu-01"
acr_name             = "acrdeddevweu01ded"        # must be globally unique
storage_account_name = "stddeddevweu01ded"        # must be globally unique (lowercase)