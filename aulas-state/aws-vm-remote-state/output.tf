output "vm_ip" {
  description = "IP Público da VM criada pelo terraform"
  value       = aws_instance.vm.public_ip
}