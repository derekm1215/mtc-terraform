terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

# download nodered image

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}