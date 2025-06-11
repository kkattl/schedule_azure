# variables.tf

variable "resource_group_name" {
  description = "The name of the existing Resource Group where the Redis Cache and Private Endpoint will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Redis Cache and Private Endpoint will be deployed. This must match the location of the Resource Group."
  type        = string
}

variable "existing_vnet_id" {
  description = "The ID of the existing Virtual Network to link the Private DNS Zone to (e.g., azurerm_virtual_network.main.id)."
  type        = string
}

variable "private_endpoint_subnet_id" {
  description = "The ID of the existing subnet where the Private Endpoint for Redis Cache will be created. This subnet MUST have 'enforce_private_link_endpoint_network_policies = true'."
  type        = string
}

# Redis Cache Specific Variables
variable "redis_cache_name" {
  description = "The globally unique name for the Azure Redis Cache instance."
  type        = string
}

variable "redis_sku_name" {
  description = "The SKU name for the Redis Cache. Options: 'Developer', 'Basic', 'Standard', 'Premium'."
  type        = string
  default     = "Basic" # Default to cheapest for development
}

variable "redis_capacity" {
  description = "The size capacity for the Redis Cache (0 for C0/P0, 1 for C1/P1, etc.)."
  type        = number
  default     = 0 # Default to smallest capacity for Developer/Basic
}

variable "redis_family" {
  description = "The SKU family for the Redis Cache. 'C' for Basic/Standard/Developer, 'P' for Premium."
  type        = string
  default     = "C"
  validation {
    condition     = contains(["C", "P"], var.redis_family)
    error_message = "Redis family must be 'C' (for Basic/Standard/Developer) or 'P' (for Premium)."
  }
}

variable "minimum_tls_version" {
  description = "The minimum TLS version to be used by the Redis Cache. Options: '1.0', '1.1', '1.2'."
  type        = string
  default     = "1.2" # Recommended for security
}

variable "private_static_ip_address" {
  description = "The static private IP address to assign to the Redis Cache. Only applicable for Premium SKU with VNet injection. Set to null if not using."
  type        = string
  default     = null # Default to no static IP for simpler setup
}

# Variables for Premium SKU features (set to null if not Premium)
variable "replicas_per_master" {
  description = "The number of replicas per master (only for Premium SKU). Set to null for other SKUs."
  type        = number
  default     = null
}

variable "shard_count" {
  description = "The number of shards to create (only for Premium SKU). Set to null for other SKUs."
  type        = number
  default     = null
}

variable "zones" {
  description = "A list of Availability Zones to deploy the Redis Cache into (only for Premium SKU). Set to [] for no zones."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to apply to all resources created by this module."
  type        = map(string)
  default     = {}
}