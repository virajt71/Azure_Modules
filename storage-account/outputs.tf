output "storage_account_name" {
  description = "Storage account name"
  value       = azurerm_storage_account.this.name
}

output "storage_account_id" {
  description = "Storage account ID"
  value       = azurerm_storage_account.this.id
}

output "primary_access_key" {
  description = "Primary access key for the storage account (sensitive)"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key for the storage account (sensitive)"
  value       = azurerm_storage_account.this.secondary_access_key
  sensitive   = true
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "container_names" {
  description = "List of container names"
  value       = [for k, v in azurerm_storage_container.this : v.name]
}

output "container_ids" {
  description = "Map of container names to container IDs"
  value       = { for k, v in azurerm_storage_container.this : v.name => v.id }
}

output "ready" {
  description = "Indicates storage account and containers are ready (after 30s delay)"
  value       = time_sleep.wait_after_container.id
  depends_on  = [time_sleep.wait_after_container]
}

