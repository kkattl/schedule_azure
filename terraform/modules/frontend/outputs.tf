output "app_private_ip" {
    value = azurerm_network_interface.app_nic.private_ip_addresses
}