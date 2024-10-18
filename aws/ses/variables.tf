variable "environment" {}

variable "project" {}

variable "domain" {}

variable "ses_domain" {}

variable "region" {
  type        = string
  description = "AWS region for the SES domain verification"
  default     = "us-east-1"
}

variable "route53_zone" {
  type        = string
  description = "Route 53 zone ID for the SES domain verification"
  default     = null
}


variable "mail_from_domain" {
  default  = null
  nullable = true
}
