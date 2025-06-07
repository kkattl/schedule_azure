variable "resource_group_name" {
  type = string
}

variable "location" {
  type        = string
  description = "Region Azure"
}

variable "prefix" {
  type        = string
  description = "Resource prefix"
}

variable "app_vm_size" {
  type        = string
  description = "Type of linux vm"
}

variable "admin_username" {
  type        = string
  description = "Username of admin for vm"
}

variable "app_vm_os_disk_caching" {
  type        = string
  description = "Caching method for vm disk"
}

variable "app_vm_os_disk_storage_account_type" {
  type        = string
  description = "Storage account type for vm disk"
}

variable "app_vm_pub_key_path" {
  type        = string
  description = "Path to ssh public key for vm"
}

variable "backend_subnet_id" {
  type        = string
  description = "ID of backend subnet"
}

variable "backend_nsg_id" {
  type        = string
  description = "Network security group id for backend subnet"
}