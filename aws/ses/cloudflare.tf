resource "cloudflare_record" "domain_amazonses_verification_record" {
  count = var.cloudflare_zone != null ? 1 : 0

  zone_id = var.cloudflare_zone
  name    = "_amazonses.${var.ses_domain}."
  type    = "TXT"
  value   = aws_ses_domain_identity.domain.verification_token
  proxied = false
  ttl     = 60
}

resource "cloudflare_record" "domain_amazonses_dkim_record" {
  count = var.cloudflare_zone != null ? 3 : 0

  zone_id = var.cloudflare_zone
  name    = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}._domainkey.${var.ses_domain}."
  type    = "CNAME"
  value   = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"
  proxied = false
  ttl     = 60
}

resource "cloudflare_record" "spf_record" {
  count = var.cloudflare_zone != null ? 1 : 0

  zone_id = var.cloudflare_zone
  name    = var.domain
  type    = "TXT"
  value   = "v=spf1 include:amazonses.com ~all"
  proxied = false
  ttl     = 60
}

resource "aws_ses_domain_identity_verification" "main" {
  domain = aws_ses_domain_identity.domain.id

  depends_on = [
    aws_route53_record.domain_amazonses_verification_record,
    cloudflare_record.domain_amazonses_verification_record,
  ]
}

resource "cloudflare_record" "feedback_mx_record" {
  count = (var.cloudflare_zone != null && var.mail_from_domain != null) ? 1 : 0

  zone_id  = var.cloudflare_zone
  name     = var.mail_from_domain
  type     = "MX"
  value    = "feedback-smtp.${var.region}.amazonaws.com"
  priority = 10
  proxied  = false
  ttl      = 60
}
