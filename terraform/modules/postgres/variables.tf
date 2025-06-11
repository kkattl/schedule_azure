# variable "administrator_login" {
#   type        = string
#   description = "The Administrator Login for the PostgreSQL Server. Changing this forces a new resource to be created."
# }

# variable "administrator_password" {
#   type        = string
#   description = "The Password associated with the administrator_login for the PostgreSQL Server."
#   sensitive   = true
# }

# variable "location" {
#   type        = string
#   description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
# }

# variable "resource_group_name" {
#   type        = string
#   description = "The name of the resource group in which to create the PostgreSQL Server. Changing this forces a new resource to be created."
# }

# variable "server_name" {
#   type        = string
#   description = "Specifies the name of the PostgreSQL Server. Changing this forces a new resource to be created."
# }

# # variable "db_charset" {
# #   type        = string
# #   default     = "UTF8"
# #   description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset. Changing this forces a new resource to be created."
# # }

# # variable "db_collation" {
# #   type        = string
# #   default     = "English_United States.1252"
# #   description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation. Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
# # }

# # variable "db_names" {
# #   type        = list(string)
# #   default     = []
# #   description = "The list of names of the PostgreSQL Database, which needs to be a valid PostgreSQL identifier. Changing this forces a new resource to be created."
# # }

# # variable "postgresql_configurations" {
# #   type        = map(string)
# #   default     = {}
# #   description = "A map with PostgreSQL configurations to enable."
# # }

# variable "public_network_access_enabled" {
#   type        = bool
#   default     = false
#   description = "Whether or not public network access is allowed for this server. Possible values are Enabled and Disabled."
# }

# variable "server_version" {
#   type        = string
#   default     = "14"
#   description = "Specifies the version of PostgreSQL to use. Valid values are `9.5`, `9.6`, `10.0`, `10.2` and `11`. Changing this forces a new resource to be created."
# }

# variable "sku_name" {
#   type        = string
#   default     = "Standard_B1ms"
#   description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8)."
# }

# variable "storage_mb" {
#   type        = number
#   default     = 32768
#   description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 4194304 MB(4TB) for General Purpose/Memory Optimized SKUs."
# }

# variable "avialibility_zone" {
#   type        = string
#   description = "PostgreSQL avialibility zone."
# }

# # variable "private_dns_zone_id" {
# #   type        = string
# #   description = "Private DNS zone ID."
# # }

# # variable "delegated_subnet_id" {
# #   type        = string
# #   description = "Delegated subnet id."
# # }

# variable "backup_retention_days" {
#   type = number
#   default = 7
#   description = "Pause between backups."
# }

# variable "geo_redundant_backup_enabled" {
#   type = bool
#   default = false
#   description = "Geo redundant backup."
# }
# variables.tf

variable "resource_group_name" {
  description = "The name of the existing Resource Group where the PostgreSQL Flexible Server will be created. Also used for Private DNS Zone."
  type        = string
}

variable "location" {
  description = "The Azure region where the PostgreSQL Flexible Server will be deployed. This must match the location of the Resource Group."
  type        = string
}

variable "existing_vnet_id" {
  description = "The ID of the existing Virtual Network to link the Private DNS Zone to (e.g., azurerm_virtual_network.main.id). Your application's client will connect from this VNet."
  type        = string
}

variable "delegated_subnet_id" {
  description = "The ID of the existing subnet that is delegated to 'Microsoft.DBforPostgreSQL/flexibleServers'. This is where the PostgreSQL server will reside."
  type        = string
}

# PostgreSQL Server Specific Variables
variable "server_name" {
  description = "The globally unique name for the Azure PostgreSQL Flexible Server instance."
  type        = string
}

variable "server_version" {
  description = "The PostgreSQL server version. Options: '11', '12', '13', '14', '15', '16'."
  type        = string
  default     = "14"
  validation {
    condition     = contains(["11", "12", "13", "14", "15", "16"], var.server_version)
    error_message = "PostgreSQL server version must be '11', '12', '13', '14', '15', or '16'."
  }
}

variable "sku_name" {
  description = "The SKU name for the Flexible Server (e.g., 'Standard_B1ms', 'Standard_D2ds_v4')."
  type        = string
  default     = "B_Standard_B1ms" # Cheapest burstable option
}

variable "storage_mb" {
  description = "The storage capacity in MB for the Flexible Server. Minimum is 20480 (20 GB)."
  type        = number
  default     = 20480 # 20 GB
}

variable "administrator_login" {
  description = "The administrator login name for the PostgreSQL server."
  type        = string
}

variable "administrator_password" {
  description = "The administrator password for the PostgreSQL server. Must meet Azure complexity requirements."
  type        = string
  sensitive   = true # Mark as sensitive for security
}

variable "availability_zone" {
  description = "The availability zone for the primary server node (e.g., '1', '2', '3')."
  type        = string
  default     = "1"
}

variable "backup_retention_days" {
  description = "The number of days to retain backups for the Flexible Server."
  type        = number
  default     = 7 # Minimum retention
}

variable "geo_redundant_backup_enabled" {
  description = "Enable or disable geo-redundant backups for the Flexible Server."
  type        = bool
  default     = false # Cheaper to disable if not needed
}

/*
variable "standby_availability_zone" {
  description = "The availability zone for the standby server node (required if high_availability_mode is 'ZoneRedundant'). Set to null if disabled."
  type        = string
  default     = null
  validation {
    condition     = var.high_availability_mode == "Disabled" || var.standby_availability_zone != null
    error_message = "standby_availability_zone must be set if high_availability_mode is 'ZoneRedundant'."
  }
}
*/

variable "private_dns_zone_prefix" {
  description = "The prefix for the Private DNS Zone name. The full name will be '<prefix>.postgres.database.azure.com'."
  type        = string
  default     = "private" # Common prefix, e.g., 'example' or 'private'
}

variable "tags" {
  description = "A map of tags to apply to all resources created by this module."
  type        = map(string)
  default     = {}
}