output "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  value       = azurerm_log_analytics_workspace.this.id
}

output "log_analytics_workspace_name" {
  description = "Log Analytics workspace name"
  value       = azurerm_log_analytics_workspace.this.name
}

output "action_group_ids" {
  description = "Map of action group IDs"
  value       = { for k, v in azurerm_monitor_action_group.this : k => v.id }
}

