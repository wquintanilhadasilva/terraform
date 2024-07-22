output "subnet_id" {
  description = "ID Subnet criada no Azzure"
  value       = azurerm_subnet.subnet.id
}

output "security_group_id" {
  description = "ID da Security Group criada na azure"
  value       = azurerm_network_security_group.nsg.id
}