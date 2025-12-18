variable "name" {
  description = "Storage account name (must be globally unique, lowercase alphanumeric and hyphens only, 3-24 characters)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$", var.name))
    error_message = "Storage account name must be 3-24 characters, lowercase alphanumeric and hyphens only, and cannot start/end with hyphen."
  }
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be either Standard or Premium."
  }
}

variable "account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"

  validation {
    condition = contains([
      "LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"
    ], var.account_replication_type)
    error_message = "Invalid replication type."
  }
}

variable "account_kind" {
  description = "Storage account kind"
  type        = string
  default     = "StorageV2"

  validation {
    condition = contains([
      "Storage", "StorageV2", "BlobStorage", "FileStorage", "BlockBlobStorage"
    ], var.account_kind)
    error_message = "Invalid account kind."
  }
}

variable "min_tls_version" {
  description = "Minimum TLS version for the storage account"
  type        = string
  default     = "TLS1_2"
}

variable "enable_versioning" {
  description = "Enable blob versioning for state files"
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft-deleted blobs"
  type        = number
  default     = 7
}

variable "containers" {
  description = "List of container names to create (e.g., ['tfstate'])"
  type        = list(string)
  default     = ["tfstate"]
}

variable "container_access_type" {
  description = "Access type for containers (private, blob, container)"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "blob", "container"], var.container_access_type)
    error_message = "Container access type must be private, blob, or container."
  }
}

variable "network_rules" {
  description = "Network rules for the storage account"
  type = object({
    default_action            = string
    ip_rules                 = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
    bypass                   = optional(list(string))
  })
  default = null
}

variable "public_network_access_enabled" {
  description = "Enable or disable public network access to the storage account"
  type        = bool
  default     = false
}

variable "enable_infrastructure_encryption" {
  description = "Enable infrastructure encryption (double encryption) for the storage account"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

