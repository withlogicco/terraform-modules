variable "environment" {}
variable "project" {}
variable "domain" {}
variable "vpc_main_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

