locals {
  project = {
    nodered = {
      int_port = 1880,
      ext_port = 1880
      image    = "nodered/node-red:latest"
    }
  }
}

module "image" {
  source   = "./image"
  image_in = var.image[terraform.workspace]
}

resource "random_string" "random" {
  for_each = local.project
  length   = 4
  special  = false
  upper    = false
}


module "container" {
  source   = "./container"
  for_each = local.project
  name_in     = join("-", [each.key, terraform.workspace, random_string.random[each.key].result])
  image_in    = module.image.image_out
  int_port_in = each.value.int_port
  ext_port_in = each.value.ext_port
  container_path_in = "/data"
}






