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

module "vnet" {
  source = "./modules/vnet"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix = var.prefix
  vnet_address_space           = var.vnet_address_space
  private_subnet_address_space = var.private_subnet_address_space
  bastion_subnet_address_space = var.bastion_subnet_address_space
}

module "nsg" {
  source = "./modules/nsg"
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
  vm_size                      = var.vm_size
  admin_username               = var.admin_username
  os_disk_caching              = var.vm_os_disk_caching
  os_disk_storage_account_type = var.vm_os_disk_storage_account_type
  pub_key_path                 = var.vm_pub_key_path
  subnet_id                    = module.vnet.private_subnet_id
  nsg_id                       = module.nsg.backend_nsg_id
}

module "app_vm" {
  source                       = "./modules/vm"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  prefix                       = var.prefix
  vm_name                      = "app"
  vm_size                      = var.vm_size
  admin_username               = var.admin_username
  os_disk_caching              = var.vm_os_disk_caching
  os_disk_storage_account_type = var.vm_os_disk_storage_account_type
  pub_key_path                 = var.vm_pub_key_path
  subnet_id                    = module.vnet.private_subnet_id
  nsg_id                       = module.nsg.app_nsg_id
}