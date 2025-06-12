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

variable "vm_name" {
  type        = string
  description = "Suffix for VM resources"
}

variable "vm_size" {
  type        = string
  description = "Type of linux vm"
}

variable "admin_username" {
  type        = string
  description = "Username of admin for vm"
}

variable "os_disk_caching" {
  type        = string
  description = "Caching method for vm disk"
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "Storage account type for vm disk"
}

variable "pub_key_path" {
  type        = string
  description = "Path to ssh public key for vm"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "nsg_id" {
  type        = string
  description = "Network security group id"
}

variable "public_ip_id" {
  type        = string
  description = "Public IP id for the VM"
  default     = null
}