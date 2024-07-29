output "vm_ip" {
  description = "IP Público da VM criada pelo terraform"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}