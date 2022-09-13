output "db_name" {
  value = aws_db_instance.main.db_name
}
output "db_host" {
  value = aws_db_instance.main.address
}
output "db_port" {
  value = aws_db_instance.main.port
}
output "db_user" {
  value = aws_db_instance.main.username
}
output "db_pass" {
  value     = random_password.main.result
  sensitive = true
}

output "secret" {
  sensitive = true
  value = {
    "db_name" = aws_db_instance.main.db_name
    "db_host" = aws_db_instance.main.address
    "db_port" = aws_db_instance.main.port
    "db_user" = aws_db_instance.main.username
    "db_pass" = random_password.main.result
  }
}
