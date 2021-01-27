output "pc_nodes" {
  value = aws_instance.pc_node.*.id
}