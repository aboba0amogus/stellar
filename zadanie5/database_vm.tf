resource "libvirt_domain" "database_domain"{
    name = "database"
    vcpu = 4
    memory = 4096
    autostart = true
    network_interface {
        network_id     = libvirt_network.terraform_network.id
        hostname       = "database"
        addresses      = ["10.100.100.20"]
    }
    disk {
        volume_id = libvirt_volume.database_volume.id
    }
}

resource "libvirt_volume" "database_volume"{
    name = "database_volume"
    size = 30 * 1024 * 1024 * 1024
    base_volume_id = libvirt_volume.base.id
    pool = "terraform_pool"
}