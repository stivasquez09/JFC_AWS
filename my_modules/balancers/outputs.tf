output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "alb_arn" {
  value = aws_lb.alb.arn
}

output "alb_listener_arn" {
  value = aws_lb_listener.listener.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}
