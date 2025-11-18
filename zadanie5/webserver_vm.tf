resource "libvirt_domain" "werberver_domain"{
    name = "webserver"
    vcpu = 2
    memory = 1024
    autostart = true
    network_interface {
        network_id     = libvirt_network.terraform_network.id
        hostname       = "webserver"
        addresses      = ["10.100.100.10"]
    }

    disk {
            volume_id = libvirt_volume.webserver_volume.id
    }
}

resource "libvirt_volume" "webserver_volume"{
    name = "webserver_volume"
    size = 20 * 1024 * 1024 * 1024
    base_volume_id = libvirt_volume.base.id
    pool = "terraform_pool"
}