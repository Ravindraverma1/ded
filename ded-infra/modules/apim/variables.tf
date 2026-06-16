variable "resource_group_name" { type = string }
variable "location"            { type = string }
variable "tags"                { type = map(string) }

variable "apim_name"       { type = string }
variable "publisher_name"  { type = string }
variable "publisher_email" { type = string }

variable "apim_subnet_id" {
  type        = string
  description = "Subnet ID for APIM VNet integration (snet-apim)"
}