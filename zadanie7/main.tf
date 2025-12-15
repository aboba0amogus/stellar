terraform {
  required_providers {
    libvirt = {
        source = "dmacvicar/libvirt"
        version = "0.7.1"
    }
  }
}

provider "libvirt" {
    alias = "kvm_local"
  uri = "qemu:///system"
}

resource "libvirt_pool" "skynet_pool"{
    name = "skynet_pool"
    type = "dir"
    path = "/home/astralinux.ru/akhristoforov/skynet_pool"
}

resource "libvirt_network" "skynet_network"{
    name = "skynet_network"
    mode = "nat"
    addresses = ["10.100.110.0/24"]
    autostart = true
}

resource "libvirt_volume" "base"{
    name = "base-img.qcow2"
    source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/cloudinit/alse-1.7.8-base-cloudinit-mg15.8.2-amd64.qcow2"
    format = "qcow2"
    pool = libvirt_pool.skynet_pool.name
}


resource "libvirt_domain" "domain"{
    name = "Pjct-Skynet-web"
    vcpu = 1
    memory = 2048
    autostart = true
    network_interface {
        network_id     = libvirt_network.skynet_network.id
        hostname       = "Pjct-Skynet-web"
    }
    disk {
        volume_id = libvirt_volume.skynet_volume.id
    }
    cloudinit = libvirt_cloudinit_disk.commoninit.id

}

resource "libvirt_cloudinit_disk" "commoninit" {
  name  = "cmn_init.iso"
  user_data = file("${path.module}/cloud-init.cfg")
  pool = libvirt_pool.skynet_pool.name
}

resource "libvirt_volume" "skynet_volume"{
    name = "skynet_volume"
    size = 30 * 1024 * 1024 * 1024
    base_volume_id = libvirt_volume.base.id
    pool = "skynet_pool"
}