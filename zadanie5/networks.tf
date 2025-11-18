resource "libvirt_network" "terraform_network"{
    name = "terraform_network"
    mode = "nat"
    addresses = ["10.100.100.0/24"]
}