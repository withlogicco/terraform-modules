resource "aws_ses_domain_identity" "domain" {
  domain = var.ses_domain
}

resource "aws_ses_domain_dkim" "dkim" {
  domain = aws_ses_domain_identity.domain.domain
}

data "aws_iam_policy_document" "ses_iam_policy" {
  statement {
    actions   = ["ses:*"]
    resources = [aws_ses_domain_identity.domain.arn]
  }
}

resource "aws_iam_policy" "main" {
  name   = "${var.project}-${var.environment}-ses-full-access"
  policy = data.aws_iam_policy_document.ses_iam_policy.json

  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ses_domain_mail_from" "main" {
  count                  = var.mail_from_domain != null ? 1 : 0
  domain                 = aws_ses_domain_identity.domain.domain
  mail_from_domain       = var.mail_from_domain
  behavior_on_mx_failure = "UseDefaultValue"
}
