output "instances_ips" {
  value = {
    for k, v in yandex_compute_instance.nodes : k => {
      internal = v.network_interface.0.ip_address
      external = v.network_interface.0.nat_ip_address
    }
  }
}
