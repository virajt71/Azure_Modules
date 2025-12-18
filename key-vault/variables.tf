variable "name" {
  description = "Key Vault name (must be globally unique)"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{3,24}$", var.name))
    error_message = "Key Vault name must be 3-24 characters, alphanumeric and hyphens only."
  }
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID"
  type        = string
}

variable "sku_name" {
  description = "SKU name (standard or premium)"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "SKU name must be either standard or premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain soft-deleted Key Vault"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Enable purge protection"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = false
}

variable "access_policies" {
  description = "List of access policies"
  type = list(object({
    tenant_id               = string
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
    storage_permissions     = optional(list(string), [])
  }))
  default = []
}

variable "network_acls" {
  description = "Network ACLs for Key Vault"
  type = object({
    default_action            = string
    bypass                    = string
    ip_rules                  = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default = null
}

variable "secrets" {
  description = "Map of secrets to create in Key Vault"
  type = map(object({
    value = string
  }))
  default = {}
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

