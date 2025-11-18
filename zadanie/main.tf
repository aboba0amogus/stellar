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

//пусть закомментирован будет пока я в офисе
/*
provider "libvirt" {
    alias = "kvm_komp"
    uri = "qemu+ssh://user@192.168.0.11/system"
}
*/

resource "libvirt_domain" "nginx"{
  name = "nginx"
  memory = 1024
  vcpu = 1
  disk {
    volume_id = libvirt_volume.nginx_disk.id
  }
}

resource "libvirt_domain" "client"{
  name = "client"
  memory = 2048
  vcpu = 2
  disk {
    volume_id = libvirt_volume.client_disk.id
  }
}

resource "libvirt_volume" "nginx_disk"{
  name = "astra_image.qcow2"
  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-1.7.5uu1-adv-qemu-mg13.1.1-amd64.qcow2"
  pool = "poolo_huyol"
}

resource "libvirt_volume" "client_disk"{
  name = "astra_image.qcow2"
  source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-1.7.5uu1-adv-qemu-mg13.1.1-amd64.qcow2"
  pool = "pool_huyool"
}

