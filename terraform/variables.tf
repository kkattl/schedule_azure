variable "az_subscription_id" {
  type        = string
  default     = "class-schedule-rg"
}

variable "resource_group_name" {
  type        = string
  default     = "class-schedule-rg"
}

variable "location" {
  type        = string
  description = "Region Azure"
  default     = "East US"
}

variable "prefix" {
  type        = string
  description = "Resourse's prefix"
}

#Vnet
variable "vnet_address_space" {
  type        = string
  description = "CIDR for Vnet"
}

variable "private_subnet_address_space" {
  type        = string
  description = "CIDR for private subnet"
}
variable "public_subnet_address_space" {
  type        = string
  description = "CIDR for private subnet"
}
variable "bastion_subnet_address_space" {
  type        = string
  description = "CIDR for bastion subnet"
}

#app_vm
variable "vm_size" {
  type = string
  description = "Type of linux vm"
}

variable "admin_username" {
  type = string
  description = "Username of admin for vm"
}

variable "vm_os_disk_caching" {
  type = string
  description = "Caching method for vm disk"
}

variable "vm_os_disk_storage_account_type" {
  type = string
  description = "Storage account type for vm disk"
}

variable "vm_pub_key_path" {
  type = string
  description = "Path to ssh public key for app vm"
}
