output "private_ip" {
  value = azurerm_network_interface.vm_nic.private_ip_addresses
}