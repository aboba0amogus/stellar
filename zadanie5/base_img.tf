resource "libvirt_volume" "base"{
    name = "base-img.qcow2"
    source = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2"
    format = "qcow2"
    pool = libvirt_pool.terraform_pool.name
}