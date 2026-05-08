data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

# Шаблон для создания ВМ
resource "yandex_compute_instance" "nodes" {
  for_each = {
    master = { cpu = 2, ram = 4, disk = 30 }
    app    = { cpu = 2, ram = 4, disk = 30 }
    srv    = { cpu = 2, ram = 4, disk = 30 }
  }

  name        = each.key
  hostname    = each.key
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = each.value.disk
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.diploma_subnet.id
    nat       = true # Выдаем публичный IP
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
