terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.az_subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

#Vnet
module "vnet" {
  source = "./modules/vnet"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix = var.prefix
  vnet_address_space           = var.vnet_address_space
  backend_subnet_address_space = var.backend_subnet_address_space
  app_subnet_address_space     = var.app_subnet_address_space
}
module "nsg" {
  source = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix              = var.prefix
}
# module "frontend" {
#   source = "./modules/frontend"
#   resource_group_name                 = azurerm_resource_group.rg.name
#   location                            = azurerm_resource_group.rg.location
#   prefix                              = var.prefix
#   app_pub_ip_allocation_method        = var.app_pub_ip_allocation_method
#   app_pub_ip_sku                      = var.app_pub_ip_sku
#   app_vm_os_disk_caching              = var.app_vm_os_disk_caching
#   app_vm_os_disk_storage_account_type = var.app_vm_os_disk_storage_account_type
#   app_vm_pub_key_path                 = var.app_vm_pub_key_path
#   app_vm_size                         = var.app_vm_size
#   admin_username                      = var.admin_username
#   app_subnet_id                       = module.vnet.app_subnet_id
#   app_nsg_id                          = module.nsg.app_nsg_id
# }
module "postgres" {
  source                 = "./modules/postgres"
  server_name            = "kaashntrpostgres"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  server_version         = "14"
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  administrator_login    = "login"
  administrator_password = "somepass"
  public_network_access_enabled = true
  backup_retention_days = 7
  geo_redundant_backup_enabled = false
  avialibility_zone      = "1"  
}
module "redis" {
  source = "./modules/redis"
  
}