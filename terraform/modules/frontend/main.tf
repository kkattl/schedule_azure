module "vnet" {
  source = "./modules/vnet"

  resource_group_name = var.resource_group_name
  location            = var.location
}

module "nsg" {
  source = "./modules/nsg"

  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_network_interface" "app-nic" {
  name                = "${prefix}-frontend"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_subnet_security_group_association" "app_subnet_nsg_association" {
  subnet_id                 = module.vnet.app_subnet.id
  network_security_group_id = module.nsg.
}

resource "azurerm_linux_virtual_machine" "app-vm" {
  name                            = "${prefix}-app"
  resource_group_name             = var.resource_group_name
  location                        = var.location    
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.app-nic.id,]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}