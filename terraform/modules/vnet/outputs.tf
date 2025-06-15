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
output "db_subnet_id" {
  value       = azurerm_subnet.db_subnet.id
}

output "redis_subnet_id" {
  value       = azurerm_subnet.redis_subnet.id
}

output "nat_public_ip" {
  value = azurerm_public_ip.nat_public_ip.ip_address
}
