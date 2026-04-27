output "rancher_url" {
  description = "Rancher web UI URL."
  value       = "https://${local.rancher_hostname}"
}

output "rancher_ip" {
  description = "Static IP of the management VM."
  value       = var.vm_static_ip
}

output "rancher_hostname" {
  description = "FQDN used by Rancher (nip.io)."
  value       = local.rancher_hostname
}

output "rancher_bootstrap_password" {
  description = "Initial Rancher bootstrap password (consumed by the downstream root)."
  value       = var.rancher_bootstrap_password
  sensitive   = true
}

output "private_network_name" {
  description = "Libvirt network name (consumed by the downstream root)."
  value       = libvirt_network.lab.name
}

output "ssh_command" {
  description = "Command to SSH into the management VM."
  value       = "ssh ${var.ssh_username}@${var.vm_static_ip}"
}
