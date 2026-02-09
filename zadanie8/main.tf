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

resource "libvirt_volume" "base"{
    name = "${var.project}_base_img"
    source = var.base_volume_path
    format = "qcow2"
    pool = "pool"
}

resource "libvirt_pool" "terraform_pool"{
    name = "pool"
    type = "dir"
    path = "/home/astralinux.ru/akhristoforov/pool"
}

resource "libvirt_network" "network"{
    name = "${var.project}_network"
    mode = "nat"
    addresses = ["${var.network}"]
}

resource "libvirt_domain" "domain"{
    name = "${var.project}_vm${count.index}"
    count = var.vms_count
    vcpu = var.cpu
    memory = var.ram
    autostart = true
    network_interface {
        network_id     = libvirt_network.network.id
        hostname       = "${var.project}_vm${count.index}"
    }
    disk {
        volume_id = libvirt_volume.volume[count.index].id
    }
    provisioner "local-exec" {
        command = "echo Vm created >> log.txt"
    }

}

resource "libvirt_volume" "volume"{
    name = "${var.project}_volume${count.index + 1}"
    count = var.vms_count
    size = var.hdd * 1024 * 1024 * 1024
    base_volume_id = libvirt_volume.base.id
    pool = "pool"
}


