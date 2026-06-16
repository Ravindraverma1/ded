variable "resource_group_name" { type = string }
variable "location" { type = string }
variable "tags" { type = map(string) }

variable "bastion_name" { type = string }
variable "bastion_subnet_id" { type = string }

variable "vm_name" { type = string }
variable "vm_subnet_id" { type = string }

variable "admin_username" { type = string }
variable "ssh_public_key" { type = string }


variable "vm_size" {
  type        = string
  description = "VM size"
}

variable "os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB"
  default     = 250
}