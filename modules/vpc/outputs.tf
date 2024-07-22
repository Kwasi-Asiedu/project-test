output "vpc_id" {
  value = aws_vpc.DT-vpc.id
}

output "public_subnets" {
  value = [aws_subnet.pub_subs[0], aws_subnet.pub_subs[1]]
}

output "private_subnets" {
  value = [aws_subnet.priv_subs[0], aws_subnet.priv_subs[1]]
}

/*output "vpc_cidr" {
  value = aws_vpc.DT-vpc.cidr_block
}*/