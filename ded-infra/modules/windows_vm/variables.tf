variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vm_name" {
  type        = string
  description = "Windows VM name"
}

variable "vm_size" {
  type        = string
  description = "VM size"
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Local administrator username"
}

variable "admin_password" {
  type        = string
  description = "Local administrator password"
  sensitive   = true
}

variable "vm_subnet_id" {
  type        = string
  description = "Subnet ID to attach NIC to"
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB"
  default     = 128
}

variable "computer_name" {
  type        = string
  description = "Windows computer name — max 15 characters"
}