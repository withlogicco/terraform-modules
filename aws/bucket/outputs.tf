output "arn" {
  value = aws_s3_bucket.main.arn
}

output "iam_policy_read_only" {
  value = aws_iam_policy.read_only.arn
}

output "iam_policy_read_write" {
  value = aws_iam_policy.read_write.arn
}

output "name" {
  value = aws_s3_bucket.main.bucket
}

output "domain_name" {
  value = aws_s3_bucket.main.bucket_domain_name
}

output "regional_domain_name" {
  value = aws_s3_bucket.main.bucket_regional_domain_name
}
