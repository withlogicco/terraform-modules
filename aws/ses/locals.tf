locals {
  tags = {
    Environment = var.environment
    Project     = var.project
    Domain      = var.domain
  }
  validation_dns_records_ses_identity = [
    {
      name     = "_amazonses.${var.ses_domain}"
      type     = "TXT"
      value    = aws_ses_domain_identity.domain.verification_token
      priority = null
    }
  ]
  validation_dns_records_dkim = [
    for i in range(length(aws_ses_domain_dkim.dkim.dkim_tokens)) : {
      name     = "${aws_ses_domain_dkim.dkim.dkim_tokens[i]}._domainkey.${var.ses_domain}"
      type     = "CNAME"
      value    = "${aws_ses_domain_dkim.dkim.dkim_tokens[i]}.dkim.amazonses.com"
      priority = null
    }
  ]
  validation_dns_records_mailfrom_mx = (var.mail_from_domain == null ? [] : [
    {
      name     = var.mail_from_domain
      type     = "MX"
      value    = "feedback-smtp.${var.region}.amazonses.com"
      priority = 10,
    }
  ])
  validation_dns_records_mailfrom_txt = (var.mail_from_domain == null ? [] : [
    {
      name     = var.mail_from_domain
      type     = "TXT"
      value    = "v=spf1 include:amazonses.com ~all"
      priority = null
    }
  ])
  validation_dns_records = concat(local.validation_dns_records_ses_identity, local.validation_dns_records_dkim, local.validation_dns_records_mailfrom_mx, local.validation_dns_records_mailfrom_txt)
}
