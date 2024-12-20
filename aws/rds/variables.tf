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
  default = "16.4"
}

variable "publicly_accessible" {
  default  = false
  nullable = false
  type     = bool
}

variable "identifier" {
  nullable = true
  type     = string
}

variable "db_name" {
  nullable = true
  type     = string
}

variable "username" {
  nullable = true
  type     = string
}

variable "db_parameters" {
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
