variable "environment" {}
variable "project" {}
variable "domain" {}
variable "lb_vpc" {}
variable "lb_domains" {
  type    = list(string)
  default = []
}
variable "route53_zone" {}
variable "subnet_ids" {}
variable "security_policy" {
  type    = string
  default = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
}
