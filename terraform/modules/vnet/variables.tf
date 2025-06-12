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
  description = "CIDR for public subnet"
}

variable "bastion_subnet_address_space" {
  type        = string
  description = "CIDR for bastion subnet"
}
