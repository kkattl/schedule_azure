resource "azurerm_postgresql_flexible_server" "main" {
  name                          = var.server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.server_version
  sku_name                      = var.sku_name
  storage_mb                    = var.storage_mb
  administrator_login           = var.administrator_login
  administrator_password        = var.administrator_password
  
  # CRITICAL: Private network access configuration
  delegated_subnet_id           = var.delegated_subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres_private_dns_zone.id
  public_network_access_enabled = false # Ensure only private access

  # Optional configurations for resilience/cost
  zone                          = var.availability_zone # Deploy in a specific availability zone
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled

  tags = var.tags
}

# ------------------------------------------------------------
# Private DNS Zone for PostgreSQL Flexible Server
# This allows clients in the VNet to resolve the PostgreSQL server's private IP.
# The name MUST follow the pattern: yourdomain.postgres.database.azure.com
# ------------------------------------------------------------
resource "azurerm_private_dns_zone" "postgres_private_dns_zone" {
  # The name here MUST be exactly 'yourdomain.postgres.database.azure.com' for Private Link
  # where 'yourdomain' is typically something generic like 'example' or 'private'
  name                = "${var.private_dns_zone_prefix}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name # Often placed in the same RG as the VNet or DB
  tags                = var.tags
}

# ------------------------------------------------------------
# Private DNS Zone Virtual Network Link
# This links the Private DNS Zone to your existing Virtual Network,
# allowing DNS resolution within that VNet.
# ------------------------------------------------------------
resource "azurerm_private_dns_zone_virtual_network_link" "postgres_dns_vnet_link" {
  name                  = "${var.server_name}-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.postgres_private_dns_zone.name
  virtual_network_id    = var.existing_vnet_id # Link to your existing VNet ID
  tags                  = var.tags
  
  # Ensure the DNS zone is created before linking the network
  depends_on = [azurerm_private_dns_zone.postgres_private_dns_zone]
}