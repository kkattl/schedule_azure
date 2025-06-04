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

  vnet_address_space          = var.vnet_address_space
  backend_subnet_address_space = var.backend_subnet_address_space
  app_subnet_address_space    = var.app_subnet_address_space
}
module "nsg" {
  source = "./modules/nsg"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  prefix = var.prefix

}