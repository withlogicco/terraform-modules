output "arn" {
  value = aws_secretsmanager_secret.main.arn
}

output "policy_arn" {
  value = aws_iam_policy.main.arn
}
