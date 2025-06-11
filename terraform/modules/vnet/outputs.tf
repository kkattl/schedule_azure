output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
}

output "backend_subnet_id" {
  value       = azurerm_subnet.backend_subnet.id
}

output "app_subnet_id" {
  value       = azurerm_subnet.app_subnet.id
}

output "bastion_subnet_id" {
  value       = azurerm_subnet.bastion_subnet.id
}

output "nat_public_ip" {
  value = azurerm_public_ip.nat_public_ip.ip_address
}