locals {
  tags = {
    Environment = var.environment
    Project     = var.project
    Domain      = var.domain
  }
}

data "aws_elb_service_account" "default" {}

resource "aws_s3_bucket" "lb_logs" {
  bucket = "${var.project}-${var.environment}-lb-logs"
  tags   = local.tags
}

data "aws_iam_policy_document" "allow_elb_access_logs" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [data.aws_elb_service_account.default.arn]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.lb_logs.bucket}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "allow_elb_access_logs" {
  bucket = aws_s3_bucket.lb_logs.id
  policy = data.aws_iam_policy_document.allow_elb_access_logs.json
}

data "aws_vpc" "main" {
  id = var.lb_vpc
}

resource "aws_security_group" "lb" {
  name   = "${var.project}-${var.environment}-lb"
  vpc_id = data.aws_vpc.main.id

  # VPC access
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
  }

  # Internet / HTTP
  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Internet / HTTPS
  ingress {
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_lb" "main" {
  name               = "${var.project}-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.lb.id]
  idle_timeout       = 120

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    enabled = true
  }
  tags = local.tags
}

resource "aws_route53_record" "lb_domain" {
  for_each = toset(var.lb_domains)
  zone_id  = var.route53_zone
  name     = replace(replace(each.key, var.domain, "."), "..", ".")
  type     = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.lb.arn
  ssl_policy        = var.security_policy

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Back-end not connected yet."
      status_code  = "200"
    }
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      port,
      protocol,
      default_action,
      ssl_policy,
    ]
  }
}
