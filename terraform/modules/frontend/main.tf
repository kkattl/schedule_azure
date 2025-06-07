module "vnet" {
  source = "../vnet"
  vnet_address_space  = var.vnet_address_space
  backend_subnet_address_space = var.backend_subnet_address_space
  app_subnet_address_space = var.app_subnet_address_space
  prefix = var.prefix
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "nsg" {
  source = "../nsg"
  prefix = var.prefix
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_network_interface" "app_nic" {
  name                = "${var.prefix}-app-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.app_public_ip.id
  }
}

resource "azurerm_public_ip" "app_public_ip" {
  name                = "${var.prefix}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.app_pub_ip_allocation_method
  sku                 = var.app_pub_ip_sku
}

resource "azurerm_subnet_security_group_association" "app_subnet_nsg_association" {
  subnet_id                 = module.vnet.app_subnet.id
  network_security_group_id = module.nsg.app_nsg
}

resource "azurerm_linux_virtual_machine" "app-vm" {
  name                            = "${var.prefix}-app"
  resource_group_name             = var.resource_group_name
  location                        = var.location    
  size                            = var.app_vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.app-nic.id,]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.app_vm_pub_key_path)
  }

  os_disk {
    caching              = var.app_vm_os_disk_caching
    storage_account_type = var.app_vm_os_disk_storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}