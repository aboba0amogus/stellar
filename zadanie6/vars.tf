variable "project" {
    type = string
    default = "project"
}

variable "network"{
    type = string
    default = "10.100.100.0/24"
}

variable "pool"{
    type = string
    default = "terraform_pool"
}

variable "base_volume_path" {
    type = string
    default = "https://dl.astralinux.ru/artifactory/mg-generic/alse/qemu/alse-vanilla-1.7.5uu1-qemu-max-mg12.5.0.qcow2"
}

variable "cpu"{
    type = number
    default = 1
}
variable "ram"{
    type = number
    default = 1024
}
variable "hdd"{
    type = number
    default = 20
}
variable "vms_count"{
    type = number
    default = 1
}