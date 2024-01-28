output "arn" {
  value       = aws_secretsmanager_secret.main.arn
  description = "The ARN of the created secret"
}

output "policy_arn" {
  value       = aws_iam_policy.main.arn
  description = "The ARN for the IAM policy granting read-only access to the secret"
}
