resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.prefix}-${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "vm_nsg_association" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = var.nsg_id
}

# resource "azurerm_subnet_network_security_group_association" "vm_nsg_association" {
#   subnet_id                 = var.subnet_id
#   network_security_group_id = var.nsg_id
# }

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "${var.prefix}-${var.vm_name}"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.vm_nic.id]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.pub_key_path)
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}