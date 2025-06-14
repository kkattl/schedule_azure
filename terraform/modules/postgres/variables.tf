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
  default     = 32768 # 20 GB
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