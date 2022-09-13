variable "project" {}
variable "environment" {}
variable "domain" {}
variable "secrets" {
  type      = list(map(any))
  sensitive = true
}
