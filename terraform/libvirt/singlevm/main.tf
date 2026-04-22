resource "libvirt_volume" "base_image" {
  name   = "${var.vm_hostname}-base.qcow2"
  pool   = var.storage_pool
  source = var.vm_image_url
  format = "qcow2"
}

resource "libvirt_volume" "vm_disk" {
  name           = "${var.vm_hostname}.qcow2"
  pool           = var.storage_pool
  base_volume_id = libvirt_volume.base_image.id
  size           = var.vm_disk_size_gb * 1024 * 1024 * 1024
  format         = "qcow2"
}

resource "libvirt_network" "private" {
  name      = "tf-private"
  mode      = "nat"
  domain    = "local"
  addresses = [var.private_network_cidr]

  dhcp {
    enabled = true
  }

  dns {
    enabled = true
  }
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name = "${var.vm_hostname}-cloudinit.iso"
  pool = var.storage_pool

  user_data = templatefile("${path.module}/cloud-init.yaml", {
    hostname       = var.vm_hostname
    ssh_username   = var.ssh_username
    ssh_public_key = trimspace(file(pathexpand(var.ssh_public_key_path)))
  })
}

resource "libvirt_domain" "vm" {
  name      = var.vm_hostname
  memory    = var.vm_memory
  vcpu      = var.vm_cpus
  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    network_id     = libvirt_network.private.id
    addresses      = [var.vm_static_ip]
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.vm_disk.id
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
