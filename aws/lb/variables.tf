variable "environment" {}
variable "project" {}
variable "domain" {}
variable "lb_vpc" {}
variable "lb_domains" {
  type    = list(string)
  default = []
}
variable "route53_zone" {}
variable "subnet_private_primary" {}
variable "subnet_private_secondary" {}
variable "subnet_public_primary" {}
variable "subnet_public_secondary" {}
variable "security_policy" {
  type    = string
  default = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
}
