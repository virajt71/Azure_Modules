# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_days

  tags = var.tags
}

# Action Group for alerts
resource "azurerm_monitor_action_group" "this" {
  for_each = var.action_groups

  name                = each.value.name
  resource_group_name = var.resource_group_name
  short_name          = each.value.short_name

  dynamic "email_receiver" {
    for_each = lookup(each.value, "email_receivers", [])
    content {
      name          = email_receiver.value.name
      email_address = email_receiver.value.email_address
    }
  }

  dynamic "sms_receiver" {
    for_each = lookup(each.value, "sms_receivers", [])
    content {
      name         = sms_receiver.value.name
      country_code = sms_receiver.value.country_code
      phone_number = sms_receiver.value.phone_number
    }
  }

  tags = var.tags
}

# Metric Alerts
resource "azurerm_monitor_metric_alert" "this" {
  for_each = var.metric_alerts

  name                = each.value.name
  resource_group_name = var.resource_group_name
  scopes              = each.value.scopes
  description         = lookup(each.value, "description", "")
  enabled             = lookup(each.value, "enabled", true)
  severity            = each.value.severity
  frequency           = lookup(each.value, "frequency", "PT1M")
  window_size         = lookup(each.value, "window_size", "PT5M")

  dynamic "criteria" {
    for_each = each.value.criteria
    content {
      metric_namespace = criteria.value.metric_namespace
      metric_name      = criteria.value.metric_name
      aggregation      = criteria.value.aggregation
      operator          = criteria.value.operator
      threshold         = criteria.value.threshold
    }
  }

  dynamic "action" {
    for_each = lookup(each.value, "action_group_ids", [])
    content {
      action_group_id = action.value
    }
  }

  tags = var.tags
}

# Diagnostic Settings for resources
resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = var.diagnostic_settings

  name                           = each.value.name
  target_resource_id             = each.value.target_resource_id
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  log_analytics_destination_type = "Dedicated"

  dynamic "enabled_log" {
    for_each = lookup(each.value, "enabled_logs", [])
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = lookup(each.value, "enabled_metrics", ["AllMetrics"])
    content {
      category = metric.value
      enabled  = true
    }
  }
}

