variable "resource_group_name" {
  type = string
}

variable "location" {
  type        = string
  description = "Region Azure"
}

variable "prefix" {
  type        = string
  description = "Resourse's prefix"
}

variable "subnet_id" {
  type        = string
  description = "ID of AzureBastionSubnet"
}