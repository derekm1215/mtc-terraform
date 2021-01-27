output "lb_target_group_arn" {
  value = aws_lb_target_group.pc_tg.arn
}

output "pc_lb" {
  value = aws_lb.pc_lb
}

output "lb_endpoint" {
  value = aws_lb.pc_lb.dns_name
}