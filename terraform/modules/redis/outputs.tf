# outputs.tf

output "redis_cache_id" {
  description = "The ID of the Azure Redis Cache instance."
  value       = azurerm_redis_cache.main.id
}

output "redis_cache_name" {
  description = "The name of the Azure Redis Cache instance."
  value       = azurerm_redis_cache.main.name
}

output "redis_cache_hostname" {
  description = "The hostname of the Azure Redis Cache instance."
  value       = azurerm_redis_cache.main.hostname
}

output "redis_cache_port" {
  description = "The SSL port of the Azure Redis Cache instance."
  value       = azurerm_redis_cache.main.ssl_port
}

output "redis_cache_primary_access_key" {
  description = "The primary access key for the Azure Redis Cache instance."
  value       = azurerm_redis_cache.main.primary_access_key
  sensitive   = true # Mark as sensitive
}

output "redis_private_endpoint_id" {
  description = "The ID of the Private Endpoint created for the Redis Cache."
  value       = azurerm_private_endpoint.redis_pep.id
}

output "redis_private_ip_address" {
  description = "The private IP address of the Redis Cache via the Private Endpoint."
  value       = azurerm_private_endpoint.redis_pep.private_service_connection[0].private_ip_address
}

output "private_dns_zone_id" {
  description = "The ID of the Private DNS Zone created for Redis Cache."
  value       = azurerm_private_dns_zone.redis_private_dns_zone.id
}