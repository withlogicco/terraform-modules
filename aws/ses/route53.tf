resource "aws_route53_record" "domain_amazonses_verification_record" {
  count   = var.route53_zone != null ? 1 : 0
  zone_id = var.route53_zone
  name    = "_amazonses.${var.ses_domain}"
  type    = "TXT"
  ttl     = "3600"
  records = [aws_ses_domain_identity.domain.verification_token]
}

resource "aws_route53_record" "domain_amazonses_dkim_record" {
  count   = var.route53_zone != null ? 3 : 0
  zone_id = var.route53_zone
  name    = "${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}._domainkey.${var.ses_domain}"
  type    = "CNAME"
  ttl     = "3600"
  records = ["${element(aws_ses_domain_dkim.dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}
