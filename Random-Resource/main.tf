terraform {
  required_providers {
    docker = {
      source  = "terraform-providers/docker"
      version = "~> 2.7.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
}

resource "random_string" "random2" {
  length  = 4
  special = false
  upper   = false
}

resource "docker_container" "nodered_container" {
  name  = join("-", ["nodered", random_string.random.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    # external = 1880
  }
}

resource "docker_container" "nodered_container2" {
  name  = join("-", ["nodered", random_string.random2.result])
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    # external = 1880
  }
}

output "ip-address" {
  value       = join(":", [docker_container.nodered_container.ip_address, docker_container.nodered_container.ports[0].external])
  description = "The IP address and external port of the container"
}

output "container-name" {
  value       = docker_container.nodered_container.name
  description = "The name of the container"
}

output "ip-address2" {
  value       = join(":", [docker_container.nodered_container2.ip_address, docker_container.nodered_container.ports[0].external])
  description = "The IP address and external port of the container"
}

output "container-name2" {
  value       = docker_container.nodered_container2.name
  description = "The name of the container"
}