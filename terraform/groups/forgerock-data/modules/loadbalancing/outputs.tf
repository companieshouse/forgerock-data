output "target_group_arn" {
  value = aws_lb_target_group.main.arn
}

output "security_group" {
  value = aws_security_group.lb.id
}
