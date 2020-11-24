terraform {
  required_providers {
    docker = {
      source = "terraform-providers/docker"
    }
  }
}

# download nodered image

provider "docker" {}