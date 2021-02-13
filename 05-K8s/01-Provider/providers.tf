terraform {
  required_providers {
    docker = {
      source = "kubernetes"
    }
  }
}

provider "kubernetes" {
   config_path    = "k3s-mtc_node-48315.yaml"
 }