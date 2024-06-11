terraform {
  required_providers {
    port = {
      source  = "port-labs/port-labs"
      version = "2.0.8"
    }
  }
}

provider "port" {
  client_id = var.port_client_id
  secret    = var.port_client_secret
}
