resource "azurerm_public_ip" "bastion_ip" {
  name                = "${var.prefix}-bastion-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "${var.prefix}-bastion"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard" 
  ip_connect_enabled = true

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}