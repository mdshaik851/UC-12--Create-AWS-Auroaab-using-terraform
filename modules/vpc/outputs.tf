output "subnet_group_name" {
  value = aws_db_subnet_group.aurora_subnet_group.name
}

output "security_group_id" {
  value = aws_security_group.aurora_sg.id
}

output "vpc" {
  value = aws_vpc.custom.id
}
