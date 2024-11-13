output "ecr_repo_arn" {
  value       = aws_ecr_repository.main.arn
  description = "The ARN of the ECR repository"
}

output "ecr_repo_url" {
  value       = aws_ecr_repository.main.repository_url
  description = "The URL of the ECR repository"
}

output "iam_policy_read_only" {
  value       = aws_iam_policy.read_only.arn
  description = "The ARN of the read-only IAM policy"
}

output "iam_policy_read_write" {
  value       = aws_iam_policy.read_write.arn
  description = "The ARN of the read-write IAM policy"
}
