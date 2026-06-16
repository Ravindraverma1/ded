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
  type = string
}
variable "computer_name" {
  type        = string
  description = "Windows computer name — max 15 characters"
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "os_disk_size_gb" {
  type    = number
  default = 128
}