variable "libvirt_uri" {
  type        = string
  description = "Libvirt connection URI."
  default     = "qemu:///system"
}

variable "private_network_cidr" {
  type        = string
  description = "CIDR for the private libvirt network."
  default     = "192.168.56.0/24"
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key injected into the VM."
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_username" {
  type        = string
  description = "Default user created by cloud-init."
  default     = "ubuntu"
}

variable "storage_pool" {
  type        = string
  description = "Libvirt storage pool used for volumes."
  default     = "default"
}

variable "vm_cpus" {
  type        = number
  description = "Number of vCPUs."
  default     = 2

  validation {
    condition     = var.vm_cpus > 0
    error_message = "vm_cpus must be greater than 0."
  }
}

variable "vm_disk_size_gb" {
  type        = number
  description = "Disk size in GB."
  default     = 20

  validation {
    condition     = var.vm_disk_size_gb > 0
    error_message = "vm_disk_size_gb must be greater than 0."
  }
}

variable "vm_hostname" {
  type        = string
  description = "Hostname assigned to the VM."
  default     = "singlevm"
}

variable "vm_image_url" {
  type        = string
  description = "URL or local path to the base cloud image (qcow2)."
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "vm_memory" {
  type        = number
  description = "Memory in MiB."
  default     = 2048

  validation {
    condition     = var.vm_memory >= 512
    error_message = "vm_memory must be at least 512 MiB."
  }
}

variable "vm_static_ip" {
  type        = string
  description = "Static IP address reserved for the VM."
  default     = "192.168.56.2"
}
