output "arn" {
  value = aws_s3_bucket.main.arn
}

output "iam_policy_read_only" {
  value = aws_iam_policy.read_only.arn
}

output "iam_policy_read_write" {
  value = aws_iam_policy.read_write.arn
}
