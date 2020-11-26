terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}


provider "docker" {}

# download nodered image

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  count   = var.container_count
  length  = 4
  special = false
  upper   = false
}


# start the container

resource "docker_container" "nodered_container" {
  name  = join("-", ["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.int_port
    external = var.ext_port
  }
}

