resource "yandex_vpc_network" "diploma_network" {
  name = "diploma-network"
}

resource "yandex_vpc_subnet" "diploma_subnet" {
  name           = "diploma-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.diploma_network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
