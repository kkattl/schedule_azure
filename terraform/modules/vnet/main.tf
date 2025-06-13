resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "${var.prefix}-private-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnet_address_space]
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "${var.prefix}-public-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnet_address_space]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.bastion_subnet_address_space]
}
