output "virtual_network_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs"
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}

output "subnet_names" {
  description = "Map of subnet names to subnet names"
  value       = { for k, v in azurerm_subnet.this : k => v.name }
}

output "public_ip_ids" {
  description = "Map of public IP keys to public IP IDs"
  value       = { for k, v in azurerm_public_ip.this : k => v.id }
}

output "public_ip_addresses" {
  description = "Map of public IP keys to public IP addresses"
  value       = { for k, v in azurerm_public_ip.this : k => v.ip_address }
}

output "network_security_group_ids" {
  description = "Map of NSG keys to NSG IDs"
  value       = { for k, v in azurerm_network_security_group.this : k => v.id }
}

output "default_nsg_id" {
  description = "Default NSG ID (if enabled)"
  value       = var.enable_default_nsg ? azurerm_network_security_group.default[0].id : null
}

output "network_interface_ids" {
  description = "Map of NIC keys to NIC IDs"
  value       = { for k, v in azurerm_network_interface.this : k => v.id }
}

output "network_interface_private_ip_addresses" {
  description = "Map of NIC keys to private IP addresses"
  value       = { for k, v in azurerm_network_interface.this : k => v.private_ip_address }
}


