#Output the IP Address of the Container
output "ip-address" {
  value = docker_container.nodered_container.ip_address
}

output "container-name" {
  value = docker_container.nodered_container.name
}
