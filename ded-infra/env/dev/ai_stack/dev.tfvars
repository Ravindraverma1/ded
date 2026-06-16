resource_group_name = "DED_Project"
location            = "westeurope"

tags = {
  env       = "dev"
  project   = "ded"
  owner     = "DED"
}

# OpenAI
openai_name        = "oai-ded-dev-weu-01"
gpt4o_version      = "2024-11-20"
gpt4o_capacity     = 10
embedding_version  = "1"
embedding_capacity = 20

# AI Search
search_name = "search-ded-dev-weu-01"
search_sku  = "basic"

# Azure Functions
func_name           = "func-ded-dev-weu-01"
func_storage_name   = "stfuncdeddevweu01"
func_python_version = "3.11"