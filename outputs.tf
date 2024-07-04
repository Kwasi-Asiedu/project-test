/*output "vpc_id" {
  value = module.Mac_VPC.vpc_id
}*/


output "vpc_id" {
  value = module.Test-VPC.vpc_id
}

output "load_balancer_dns_name" {
  value = module.Test-ALB.load_balancer_dns_name
}

