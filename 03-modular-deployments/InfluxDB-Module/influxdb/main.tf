resource "docker_image" "infuxdb_image" {
  name  = "influxdb"
  image = "influxdb"
  ports {
    internal = 8086
    external = 8086
  }
  volumes {
    container_path = "/var/lib/influxdb"
    volume_name    = docker_volume.container_volume.name
  }
}

resource "docker_volume" "container_volume" {
  lifecycle {
    prevent_destroy = true
  }
}