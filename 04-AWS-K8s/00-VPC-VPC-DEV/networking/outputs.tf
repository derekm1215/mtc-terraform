output "vpc_id" {
  value = aws_vpc.mtc_vpc.id
}

output "public_subnets" {
  value = aws_subnet.pc_public_subnet.*.id
}

output "private_subnets" {
  value = aws_subnet.pc_private_subnet.*.id
}

output "subnet_ips" {
  value = aws_subnet.pc_public_subnet.*.cidr_block
}

output "public_route_table" {
  value = aws_route_table.pc_public_rt
}

output "private_route_table" {
  value = aws_default_route_table.pc_private_rt
}

output "public_security_group" {
  value = aws_security_group.pc_public_sg.id
}

output "db_security_group" {
  value = aws_security_group.pc_rds_sg
}

output "vpc_security_group_ids" {
  value = [aws_security_group.pc_rds_sg.id]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.pc_rds_subnetgroup.*.name
}