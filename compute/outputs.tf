output "vm_ids" {
  description = "Map of VM keys to VM IDs"
  value       = { for k, v in azurerm_linux_virtual_machine.this : k => v.id }
}

output "vm_names" {
  description = "Map of VM keys to VM names"
  value       = { for k, v in azurerm_linux_virtual_machine.this : k => v.name }
}

output "vm_private_ip_addresses" {
  description = "Map of VM keys to private IP addresses"
  value       = { for k, v in azurerm_linux_virtual_machine.this : k => v.private_ip_address }
}

output "vm_public_ip_addresses" {
  description = "Map of VM keys to public IP addresses (if available)"
  value       = { for k, v in azurerm_linux_virtual_machine.this : k => v.public_ip_address }
}

output "generated_passwords" {
  description = "Map of VM keys to generated admin passwords (sensitive)"
  value       = { for k, v in random_password.this : k => v.result }
  sensitive   = true
}

output "ssh_public_keys" {
  description = "Map of VM keys to generated SSH public keys"
  value       = { for k, v in azapi_resource_action.ssh_public_key_gen : k => v.output.publicKey }
  sensitive   = false
}

output "ssh_private_keys" {
  description = "Map of VM keys to generated SSH private keys (sensitive)"
  value       = { for k, v in azapi_resource_action.ssh_public_key_gen : k => v.output.privateKey }
  sensitive   = true
}

output "ssh_key_resource_ids" {
  description = "Map of VM keys to SSH key resource IDs"
  value       = { for k, v in azapi_resource.ssh_public_key : k => v.id }
}

