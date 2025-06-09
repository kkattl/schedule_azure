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

variable "app_vm_size" {
  type = string
  description = "Type of linux vm"
}

variable "admin_username" {
  type = string
  description = "Username of admin for vm"
}

variable "app_pub_ip_allocation_method" {
  type = string
  description = "Allocation method for app public ip"
}

variable "app_pub_ip_sku" {
  type = string
  description = "Sku method for app public ip"
}

variable "app_vm_os_disk_caching" {
  type = string
  description = "Caching method for vm disk"
}

variable "app_vm_os_disk_storage_account_type" {
  type = string
  description = "Storage account type for vm disk"
}

variable "app_vm_pub_key_path" {
  type = string
  description = "Path to ssh public key for app vm"
}
variable "app_subnet_id" {
  type        = string
  description = "ID for app subnet"
}

variable "app_nsg_id" {
  type        = string
  description = "app network security group"
}
