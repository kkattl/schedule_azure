variable "resource_group_name" {
  type        = string
}

variable "location" {
  type        = string
  description = "Region Azure"
}

variable "prefix" {
  type        = string
  description = "Resourse's prefix"
}

variable "vm_size" {
  type = string
  description = "Type of linux vm"
}

variable "admin_username" {
  type = string
  description = "Username of admin for vm"
}