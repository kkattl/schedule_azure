resource "azurerm_postgresql_flexible_server" "free_tier_db" {
  name                          = var.server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.server_version
  sku_name                      = var.sku_name
  storage_mb                    = var.storage_mb
  administrator_login           = var.administrator_login
  administrator_password        = var.administrator_password
  public_network_access_enabled = var.public_network_access_enabled
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled
  zone                          = var.avialibility_zone
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_my_ip" {
  name             = "RuleForDb"
  server_id        = azurerm_postgresql_flexible_server.free_tier_db.id
  start_ip_address = "31.128.191.187"
  end_ip_address   = "31.128.191.187"
}