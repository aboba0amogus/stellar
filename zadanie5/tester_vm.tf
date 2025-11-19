resource "libvirt_domain" "tester_domain"{
    name = "tester"
    vcpu = 4
    memory = 4096
    running = false
    boot_device {
        dev = [ "cdrom","hd", "network"]
    }
    network_interface {
        network_id     = libvirt_network.terraform_network.id
        hostname       = "tester"
    }
    disk{
        file = "/home/astralinux.ru/akhristoforov/iso/installation-1.8.2.8-06.05.25_11.44.iso"
    }
    disk{
        volume_id = libvirt_volume.tester_volume.id
    }
}

resource "libvirt_volume" "tester_volume"{
    name = "tester_voulume.qcow2"
    size = 20 * 1024 * 1024 * 1024
    pool = "terraform_pool"
}