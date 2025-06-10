variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
  default     = "my-resource-group"
}

variable "resource_group_location" {
  description = "Location for the Azure resource group."
  type        = string
  default     = "East US"
}

variable "environment" {
  description = "Environment tag for resources."
  type        = string
  default     = "dev"
}

variable "name" {
  description = "Name tag for resources."
  type        = string
  default     = "my-app"
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "redis_server_settings" {
  type = map(object({
    capacity                      = number
    sku_name                      = string
    enable_non_ssl_port           = optional(bool)
    minimum_tls_version           = optional(string)
    private_static_ip_address     = optional(string)
    public_network_access_enabled = optional(string)
    replicas_per_master           = optional(number)
    shard_count                   = optional(number)
    zones                         = optional(list(string))
  }))
  description = "optional redis server setttings for both Premium and Standard/Basic SKU"
  default     = {}
}

variable "redis_family" {
  type        = map(any)
  description = "The SKU family/pricing group to use. Valid values are `C` (for `Basic/Standard` SKU family) and `P` (for `Premium`)"
  default = {
    Basic    = "C"
    Standard = "C"
    Premium  = "P"
  }
}

variable "subnet_id" {
  description = "ID of the subnet for Premium Redis."
  type        = string
  default     = ""
}

variable "data_persistence_backup_frequency" {
  description = "The Backup Frequency in Minutes. Only supported on Premium SKU's. Possible values are: `15`, `30`, `60`, `360`, `720` and `1440`"
  default     = 60
}

variable "data_persistence_backup_max_snapshot_count" {
  description = "The maximum number of snapshots to create as a backup. Only supported for Premium SKU's"
  default     = 1
}

variable "patch_schedule" {
  type = object({
    day_of_week    = string
    start_hour_utc = number
  })
  description = "The window for redis maintenance. The Patch Window lasts for 5 hours from the `start_hour_utc` "
  default     = null
}

variable "firewall_rules" {
  description = "Range of IP addresses to allow firewall connections."
  type = map(object({
    start_ip = string
    end_ip   = string
  }))
  default = null
}

variable "create_vnet" {
  description = "Create a virtual network."
  type        = bool
  default     = false
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
  type        = string
  default     = ""
}

variable "vnet_name" {
  description = "Name of an existing virtual network."
  type        = string
  default     = ""
}

variable "vnet_resource_group_name" {
  description = "Resource group name for an existing virtual network."
  type        = string
  default     = ""
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet."
  type        = string
  default     = ""
}

variable "private_endpoint_enabled" {
  description = "Enable private endpoint for Redis."
  type        = bool
  default     = false
}

variable "vnet_id" {
  description = "ID of an existing virtual network for private endpoint."
  type        = string
  default     = ""
}

variable "diagnostics_enabled" {
  description = "Enable diagnostics settings."
  type        = bool
  default     = false
}

variable "data_persistence_enabled" {
  description = "Enable data persistence for Redis Cache."
  type        = bool
  default     = false
}
