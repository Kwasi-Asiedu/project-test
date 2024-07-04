output "load_balancer_dns_name" {
  value = aws_alb.DT-alb.dns_name
}

output "alb_sg_id" {
  value = aws_alb.DT-alb.security_groups
}

output "target-group" {
  value = aws_lb_target_group.DT-TG.arn
}

output "lb-zone-id" {
  value = aws_alb.DT-alb.zone_id
}