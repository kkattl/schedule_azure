output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
}

output "private_subnet_id" {
  value       = azurerm_subnet.private_subnet.id
}

output "public_subnet_id" {
  value       = azurerm_subnet.private_subnet.id
}

output "bastion_subnet_id" {
  value       = azurerm_subnet.bastion_subnet.id
}
