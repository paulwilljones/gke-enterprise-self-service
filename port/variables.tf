variable "port_client_id" {
  type = string
}

variable "port_client_secret" {
  sensitive = true
  type      = string
}
