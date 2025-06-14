terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "class-schedule-rg"  # Name of the resource group where your storage account resides
  #   storage_account_name = "storageaccount"
  #   container_name       = "tfstate"                # Name of the blob container for state files
  #   key                  = "terraform.tfstate"      # The path/name of the state file within the container
  # }
}
provider "azurerm" {
  features {}
  subscription_id = var.az_subscription_id
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# resource "azurerm_storage_account" "storage_account" {
#   name                     = "storageaccount"
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = azurerm_resource_group.rg.location
#   account_tier             = "Standard"
#   account_replication_type = "GRS"
# }

module "vnet" {
  source = "./modules/vnet"

  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  prefix                       = var.prefix
  vnet_address_space           = var.vnet_address_space
  backend_subnet_address_space = var.backend_subnet_address_space
  app_subnet_address_space     = var.app_subnet_address_space
  bastion_subnet_address_space = var.bastion_subnet_address_space
  db_subnet_address_space      = var.db_subnet_address_space
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix              = var.prefix
}

module "bastion" {
  source              = "./modules/bastion"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix              = var.prefix
  subnet_id           = module.vnet.bastion_subnet_id
}

module "backend_vm" {
  source                       = "./modules/vm"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  prefix                       = var.prefix
  vm_name                      = "backend"
  vm_size                      = var.app_vm_size
  admin_username               = var.admin_username
  os_disk_caching              = var.app_vm_os_disk_caching
  os_disk_storage_account_type = var.app_vm_os_disk_storage_account_type
  pub_key_path                 = var.app_vm_pub_key_path
  subnet_id                    = module.vnet.backend_subnet_id
  nsg_id                       = module.nsg.backend_nsg_id
}

module "app_vm" {
  source                       = "./modules/vm"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  prefix                       = var.prefix
  vm_name                      = "app"
  vm_size                      = var.app_vm_size
  admin_username               = var.admin_username
  os_disk_caching              = var.app_vm_os_disk_caching
  os_disk_storage_account_type = var.app_vm_os_disk_storage_account_type
  pub_key_path                 = var.app_vm_pub_key_path
  subnet_id                    = module.vnet.app_subnet_id
  nsg_id                       = module.nsg.app_nsg_id
}

# module "postgres" {
#   source = "./modules/postgres"
#   server_name = "postgres"
#   location = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   existing_vnet_id = module.vnet.vnet_id
#   delegated_subnet_id = module.vnet.db_subnet_id
#   administrator_login = "login"
#   administrator_password = "BestPassword123!"
# }