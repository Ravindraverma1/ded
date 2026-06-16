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
  type = string
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
  type = string
}

variable "search_sku" {
  type    = string
  default = "basic"
}

variable "func_name" {
  type = string
}

variable "func_storage_name" {
  type = string
}

variable "func_python_version" {
  type    = string
  default = "3.11"
}