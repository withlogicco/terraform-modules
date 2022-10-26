output "vpc" {
  value = aws_vpc.main.id
}

output "subnet_private_primary" {
  value = aws_subnet.private_primary.id
}

output "subnet_private_secondary" {
  value = aws_subnet.private_secondary.id
}

output "subnet_public_primary" {
  value = aws_subnet.public_primary.id
}

output "subnet_public_secondary" {
  value = aws_subnet.public_secondary.id
}

output "security_group_vpc" {
  value = aws_security_group.vpc.id
}
