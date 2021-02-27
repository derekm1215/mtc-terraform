resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "echo hello world!"
  }
}