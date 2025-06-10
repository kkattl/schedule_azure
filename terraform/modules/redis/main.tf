resource "azurerm_redis_cache" "redis" {
  for_each                      = var.redis_server_settings
  name                          = format("%s-%s-%s", var.environment, var.name, each.key)
  resource_group_name           = var.resource_group_name
  location                      = var.resource_group_location
  capacity                      = each.value["capacity"]
  family                        = lookup(var.redis_family, each.value.sku_name)
  sku_name                      = each.value["sku_name"]
  minimum_tls_version           = each.value["minimum_tls_version"]
  private_static_ip_address     = each.value["private_static_ip_address"]
  public_network_access_enabled = each.value["public_network_access_enabled"]
  replicas_per_master           = each.value["sku_name"] == "Premium" ? each.value["replicas_per_master"] : null
  shard_count                   = each.value["sku_name"] == "Premium" ? each.value["shard_count"] : null
  subnet_id                     = each.value["sku_name"] == "Premium" ? azurerm_subnet.snet-ep.0.id : null
  zones                         = each.value["zones"]
  tags                          = var.tags

  dynamic "patch_schedule" {
    for_each = var.patch_schedule != null ? [var.patch_schedule] : []
    content {
      day_of_week    = var.patch_schedule.day_of_week
      start_hour_utc = var.patch_schedule.start_hour_utc
    }
  }

  lifecycle {
    ignore_changes = [redis_configuration.0.rdb_storage_connection_string]
  }
}

# Adding Firewall rules for Redis Cache Instance
resource "azurerm_redis_firewall_rule" "name" {
  depends_on          = [azurerm_resource_group.default]
  for_each            = var.firewall_rules != null ? { for k, v in var.firewall_rules : k => v if v != null } : {}
  name                = format("%s_%s_%s", var.environment, var.name, each.key)
  redis_cache_name    = element([for n in azurerm_redis_cache.main : n.name], 0)
  resource_group_name = azurerm_resource_group.default.name
  start_ip            = each.value["start_ip"]
  end_ip              = each.value["end_ip"]
}