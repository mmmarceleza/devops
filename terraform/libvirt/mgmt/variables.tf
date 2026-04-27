variable "libvirt_uri" {
  type        = string
  description = "Libvirt connection URI."
  default     = "qemu:///system"
}

variable "private_network_cidr" {
  type        = string
  description = "CIDR for the libvirt lab network."
  default     = "192.168.56.0/24"
}

variable "private_network_name" {
  type        = string
  description = "Libvirt network name shared with the downstream cluster."
  default     = "tf-rancher-lab"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key injected into the VM."
  default     = "~/.ssh/vagrant.pub"
}

variable "ssh_username" {
  type        = string
  description = "Default user created by cloud-init."
  default     = "opc"
}

variable "storage_pool" {
  type        = string
  description = "Libvirt storage pool used for volumes."
  default     = "default"
}

variable "vm_image_url" {
  type        = string
  description = "URL or local path to the base cloud image (qcow2)."
  default     = "https://yum.oracle.com/templates/OracleLinux/OL9/u5/x86_64/OL9U5_x86_64-kvm-b259.qcow2"
}

variable "vm_hostname" {
  type        = string
  description = "Hostname assigned to the management VM."
  default     = "rancher-mgmt"
}

variable "vm_static_ip" {
  type        = string
  description = "Static IP address reserved for the management VM."
  default     = "192.168.56.10"
}

variable "vm_cpus" {
  type        = number
  description = "vCPUs for the management VM."
  default     = 4

  validation {
    condition     = var.vm_cpus >= 2
    error_message = "vm_cpus must be at least 2 (RKE2 minimum)."
  }
}

variable "vm_memory" {
  type        = number
  description = "Memory in MiB for the management VM."
  default     = 8192

  validation {
    condition     = var.vm_memory >= 4096
    error_message = "vm_memory must be at least 4096 MiB (RKE2 minimum)."
  }
}

variable "vm_disk_size_gb" {
  type        = number
  description = "Disk size in GB. Must be at least the base image virtual size (37 GiB for OL9)."
  default     = 60

  validation {
    condition     = var.vm_disk_size_gb >= 37
    error_message = "vm_disk_size_gb must be at least 37 (Oracle Linux 9 cloud image virtual size)."
  }
}

variable "rke2_version" {
  type        = string
  description = "RKE2 version installed on the management cluster."
  default     = "v1.31.6+rke2r1"
}

variable "rancher_version" {
  type        = string
  description = "Rancher Helm chart version."
  default     = "2.10.3"
}

variable "cert_manager_version" {
  type        = string
  description = "cert-manager Helm chart version."
  default     = "v1.16.2"
}

variable "rancher_bootstrap_password" {
  type        = string
  description = "Initial Rancher bootstrap password. Used to log in the first time and to bootstrap from the downstream root."
  default     = "RancherLab2026!"
  sensitive   = true
}
