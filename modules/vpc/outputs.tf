output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets_private_ids" {
  value = values(aws_subnet.subnets_private)[*].id
}
