variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "log_analytics_sku" {
  description = "SKU for Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_days" {
  description = "Log retention in days"
  type        = number
  default     = 30
}

variable "action_groups" {
  description = "Map of action groups for alerts"
  type = map(object({
    name       = string
    short_name = string
    email_receivers = optional(list(object({
      name          = string
      email_address = string
    })), [])
    sms_receivers = optional(list(object({
      name         = string
      country_code = string
      phone_number = string
    })), [])
  }))
  default = {}
}

variable "metric_alerts" {
  description = "Map of metric alerts"
  type = map(object({
    name         = string
    scopes       = list(string)
    description  = optional(string)
    enabled      = optional(bool, true)
    severity     = number
    frequency    = optional(string, "PT1M")
    window_size  = optional(string, "PT5M")
    criteria = list(object({
      metric_namespace = string
      metric_name      = string
      aggregation      = string
      operator          = string
      threshold         = number
    }))
    action_group_ids = optional(list(string), [])
  }))
  default = {}
}

variable "diagnostic_settings" {
  description = "Map of diagnostic settings for resources"
  type = map(object({
    name             = string
    target_resource_id = string
    enabled_logs     = optional(list(string), [])
    enabled_metrics   = optional(list(string), ["AllMetrics"])
  }))
  default = {}
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

