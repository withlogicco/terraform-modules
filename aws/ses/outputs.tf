output "domain_identity_arn" {
  description = "ARN of the SES domain identity"
  value       = aws_ses_domain_identity.domain.arn
}

output "policy_arn" {
  description = "ARN of the SES domain identity policy"
  value       = aws_iam_policy.main.arn
}

output "validation_dns_records" {
  description = "DNS records to validate SES"
  value       = local.validation_dns_records
}
