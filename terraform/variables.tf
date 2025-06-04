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

variable "backend_subnet_address_space" {
  type        = string
  description = "CIDR for backend subnet"
}

variable "app_subnet_address_space" {
  type        = string
  description = "CIDR for app subnet"
}
