resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = var.sku_name

  # Security: Enable soft delete and purge protection
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  
  # Network access
  public_network_access_enabled = var.public_network_access_enabled
  
  # Access policies
  dynamic "access_policy" {
    for_each = var.access_policies
    content {
      tenant_id = access_policy.value.tenant_id
      object_id = access_policy.value.object_id

      key_permissions         = access_policy.value.key_permissions
      secret_permissions      = access_policy.value.secret_permissions
      certificate_permissions = access_policy.value.certificate_permissions
      storage_permissions     = lookup(access_policy.value, "storage_permissions", [])
    }
  }

  # Network rules
  dynamic "network_acls" {
    for_each = var.network_acls != null ? [1] : []
    content {
      default_action             = var.network_acls.default_action
      bypass                     = var.network_acls.bypass
      ip_rules                   = var.network_acls.ip_rules
      virtual_network_subnet_ids = var.network_acls.virtual_network_subnet_ids
    }
  }

  tags = var.tags
}

# Secrets (optional - can be managed separately)
resource "azurerm_key_vault_secret" "this" {
  for_each = var.secrets

  name         = each.key
  value        = each.value.value
  key_vault_id = azurerm_key_vault.this.id

  tags = var.tags
}

