variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "openai_name" {
  type        = string
  description = "Azure OpenAI account name"
}

variable "gpt4o_version" {
  type    = string
  default = "2024-05-13"
}

variable "gpt4o_capacity" {
  type    = number
  default = 10
}

variable "embedding_version" {
  type    = string
  default = "1"
}

variable "embedding_capacity" {
  type    = number
  default = 20
}

variable "search_name" {
  type        = string
  description = "Azure AI Search service name"
}

variable "search_sku" {
  type    = string
  default = "basic"
}

variable "func_name" {
  type        = string
  description = "Azure Function App name"
}

variable "func_storage_name" {
  type        = string
  description = "Storage account name (max 24 chars, lowercase, no hyphens)"
}

variable "func_python_version" {
  type    = string
  default = "3.11"
}

variable "private_endpoints_subnet_id" {
  type        = string
  description = "Subnet ID for private endpoints (snet-private-endpoints)"
}

variable "openai_private_dns_zone_id" {
  type        = string
  description = "Private DNS zone ID for privatelink.openai.azure.com"
}

variable "search_private_dns_zone_id" {
  type        = string
  description = "Private DNS zone ID for privatelink.search.windows.net"
}