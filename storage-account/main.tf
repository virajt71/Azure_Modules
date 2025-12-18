resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind
  min_tls_version          = var.min_tls_version
  
  # Security: Disable public network access by default
  public_network_access_enabled = var.public_network_access_enabled
  
  # Security: Enable infrastructure encryption
  infrastructure_encryption_enabled = var.enable_infrastructure_encryption

  # Enable blob versioning and soft delete for state files
  blob_properties {
    versioning_enabled       = var.enable_versioning
    delete_retention_policy {
      days = var.soft_delete_retention_days
    }
  }

  # Network rules
  dynamic "network_rules" {
    for_each = var.network_rules != null ? [1] : []
    content {
      default_action             = var.network_rules.default_action
      ip_rules                   = var.network_rules.ip_rules
      virtual_network_subnet_ids  = var.network_rules.virtual_network_subnet_ids
      bypass                     = var.network_rules.bypass
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each = toset(var.containers)

  name                  = each.value
  storage_account_id  = azurerm_storage_account.this.id
  container_access_type = var.container_access_type
}

# Wait 30 seconds after container creation to ensure storage account is fully ready
resource "time_sleep" "wait_after_container" {
  depends_on = [azurerm_storage_container.this]

  create_duration = "30s"
}

