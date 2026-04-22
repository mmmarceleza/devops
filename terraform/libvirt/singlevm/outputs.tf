output "ssh_command" {
  description = "Command to SSH into the VM."
  value       = "ssh ${var.ssh_username}@${var.vm_static_ip}"
}

output "vm_ip" {
  description = "Static IP assigned to the VM."
  value       = var.vm_static_ip
}
