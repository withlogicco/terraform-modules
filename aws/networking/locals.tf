locals {
  tags = {
    Environment = var.environment
    Project   = var.project
    Domain = var.domain
  }
}