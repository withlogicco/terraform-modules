output "vpc" {
  value = aws_vpc.main.id
}

output "subnet_primary" {
  value = aws_subnet.primary.id
}

output "subnet_secondary" {
  value = aws_subnet.secondary.id
}

output "security_group_vpc" {
  value = aws_security_group.vpc.id
}
