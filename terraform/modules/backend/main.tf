resource "azurerm_network_interface" "backend_nic" {
  name                = "${var.prefix}-backend-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.backend_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_subnet_network_security_group_association" "backend_subnet_nsg_association" {
  subnet_id                 = var.backend_subnet_id
  network_security_group_id = var.backend_nsg_id
}

resource "azurerm_linux_virtual_machine" "backend_vm" {
  name                            = "${var.prefix}-backend"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.app_vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.backend_nic.id]

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