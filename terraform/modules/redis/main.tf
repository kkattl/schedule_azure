# main.tf

# ------------------------------------------------------------
# Azure Redis Cache Instance
# This resource creates the Redis Cache itself.
# It is configured for private network access only.
# ------------------------------------------------------------
resource "azurerm_redis_cache" "main" {
  name                          = var.redis_cache_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  capacity                      = var.redis_capacity # e.g., 0 for C0/P0, 1 for C1/P1
  family                        = var.redis_family   # e.g., "C" for Basic/Standard, "P" for Premium
  sku_name                      = var.redis_sku_name # e.g., "Developer", "Basic", "Standard", "Premium"
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = false # CRITICAL: Ensure only private access

  # Replicas and Shard count are only applicable for Premium SKU
  replicas_per_master = var.redis_sku_name == "Premium" ? var.replicas_per_master : null
  shard_count         = var.redis_sku_name == "Premium" ? var.shard_count : null

  # Zones are for Premium SKU for Availability Zone deployment
  zones               = var.redis_sku_name == "Premium" ? var.zones : null

  # Private Static IP is for Premium SKU with VNet injection, often used with Private Link too.
  # For Private Link, the PE gets the IP, not necessarily the cache itself for Basic/Standard/Developer.
  # If a specific static IP is desired for the cache, it's typically for Premium with VNet injection.
  # Since we're using Private Link, the Private Endpoint handles the IP.
  private_static_ip_address = var.private_static_ip_address

  tags = var.tags
}

# ------------------------------------------------------------
# Private Endpoint for Redis Cache
# This allows the Redis Cache to be accessed privately via the VNet.
# ------------------------------------------------------------
resource "azurerm_private_endpoint" "redis_pep" {
  name                = "${var.redis_cache_name}-pep"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id # Use the ID of the existing subnet

  tags = var.tags

  private_service_connection {
    name                           = "${var.redis_cache_name}-psc"
    is_manual_connection           = false # Set to true if approval is required
    private_connection_resource_id = azurerm_redis_cache.main.id
    subresource_names              = ["redisCache"] # Specific subresource for Redis Cache
  }
}

# ------------------------------------------------------------
# Private DNS Zone for Redis Cache (MUST be exactly this name)
# This allows clients in the VNet to resolve the Redis Cache's private IP.
# ------------------------------------------------------------
resource "azurerm_private_dns_zone" "redis_private_dns_zone" {
  name                = "privatelink.redis.cache.windows.net" # REQUIRED EXACT NAME for Redis
  resource_group_name = var.resource_group_name                # Place in the same RG as other networking
  tags                = var.tags
}

# ------------------------------------------------------------
# Private DNS Zone Virtual Network Link
# This links the Private DNS Zone to your existing Virtual Network.
# ------------------------------------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "redis_dns_vnet_link" {
  name                  = "${var.redis_cache_name}-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.redis_private_dns_zone.name
  virtual_network_id    = var.existing_vnet_id # Link to your existing VNet ID
  tags                  = var.tags
}

# ------------------------------------------------------------
# Private DNS A Record for the Redis Cache
# This maps the Redis Cache's hostname to its private IP within the DNS zone.
# ------------------------------------------------------------
resource "azurerm_private_dns_a_record" "redis_a_record" {
  name                = var.redis_cache_name # Redis hostname will be `name.privatelink.redis.cache.windows.net`
  zone_name           = azurerm_private_dns_zone.redis_private_dns_zone.name
  resource_group_name = azurerm_private_dns_zone.redis_private_dns_zone.resource_group_name
  ttl                 = 300 # Time To Live for the DNS record
  records             = [azurerm_private_endpoint.redis_pep.private_service_connection[0].private_ip_address]

  tags = var.tags
}