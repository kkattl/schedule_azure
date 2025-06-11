# outputs.tf

output "server_id" {
  description = "The ID of the Azure PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.id
}

output "server_name" {
  description = "The name of the Azure PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.name
}

output "server_hostname" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "server_administrator_login" {
  description = "The administrator login name for the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.administrator_login
}

output "server_administrator_password" {
  description = "The administrator password for the PostgreSQL Flexible Server."
  value       = azurerm_postgresql_flexible_server.main.administrator_password
  sensitive   = true # Mark as sensitive
}

output "private_dns_zone_id" {
  description = "The ID of the Private DNS Zone created for PostgreSQL Flexible Server."
  value       = azurerm_private_dns_zone.postgres_private_dns_zone.id
}