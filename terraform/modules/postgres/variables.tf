variable "administrator_login" {
  type        = string
  description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
}

variable "administrator_password" {
  type        = string
  description = "The Password associated with the administrator_login for the PostgreSQL Server."
  sensitive   = true
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
}

variable "server_name" {
  type        = string
  description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
}

# variable "db_charset" {
#   type        = string
#   default     = "UTF8"
#   description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created."
# }

# variable "db_collation" {
#   type        = string
#   default     = "English_United States.1252"
#   description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
# }

# variable "db_names" {
#   type        = list(string)
#   default     = []
#   description = "The list of names of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created."
# }

# variable "postgresql_configurations" {
#   type        = map(string)
#   default     = {}
#   description = "A map with PostgreSQL configurations to enable."
# }

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Whether or not public network access is allowed for this server. Possible values are Enabled and Disabled."
}

variable "server_version" {
  type        = string
  default     = "14"
  description = "Specifies the version of PostgreSQL to use. Valid values are `9.5`, `9.6`, `10.0`, `10.2` and `11`. Changing this forces a new resource to be created."
}

variable "sku_name" {
  type        = string
  default     = "Standard_B1ms"
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
}

variable "storage_mb" {
  type        = number
  default     = 32768
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
}

variable "avialibility_zone" {
  type        = string
  description = "PostgreSQL avialibility zone."
}

# variable "private_dns_zone_id" {
#   type        = string
#   description = "Private DNS zone ID."
# }

# variable "delegated_subnet_id" {
#   type        = string
#   description = "Delegated subnet id."
# }

variable "backup_retention_days" {
  type = number
  default = 7
  description = "Pause between backups."
}

variable "geo_redundant_backup_enabled" {
  type = bool
  default = false
  description = "Geo redundant backup."
}