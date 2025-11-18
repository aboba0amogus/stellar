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