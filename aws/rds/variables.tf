variable "project" {}
variable "environment" {}
variable "domain" {}
variable "subnet_primary" {}
variable "subnet_secondary" {}
variable "security_group" {}
variable "rds_instance_class" {
  default = "db.t3.micro"
}
variable "engine_version" {
  default = "14.7"
}
