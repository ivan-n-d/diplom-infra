variable "yandex_token" {
  type        = string
  description = "Yandex Cloud OAuth token"
  sensitive   = true
}
variable "cloud_id" { type = string }
variable "folder_id" { type = string }
variable "zone" {
  type    = string
  default = "ru-central1-a"
}
