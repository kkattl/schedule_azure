output "backend_private_ip" {
  value = azurerm_network_interface.backend_nic.private_ip_addresses
}