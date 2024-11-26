locals {
  name = "${var.project}-${var.environment}"
  tags = {
    Environment = var.environment
    Project     = var.project
    Domain      = var.domain
  }
}

resource "aws_db_subnet_group" "main" {
  name       = local.name
  subnet_ids = [var.subnet_primary, var.subnet_secondary]
  tags       = local.tags
}

resource "random_password" "main" {
  length           = 32
  special          = true
  override_special = "_$"
}

resource "aws_db_parameter_group" "main" {
  name   = local.name
  family = "postgres16"
  tags   = local.tags
}

resource "aws_db_instance" "main" {
  identifier                = (var.identifier != null) ? var.identifier : local.name
  allocated_storage         = 20
  max_allocated_storage     = 100
  engine                    = "postgres"
  engine_version            = var.engine_version
  instance_class            = var.rds_instance_class
  db_name                   = (var.db_name != null) ? var.db_name : var.project
  username                  = (var.username != null) ? var.username : "${var.project}_root"
  password                  = random_password.main.result
  parameter_group_name      = aws_db_parameter_group.main.name
  final_snapshot_identifier = "${local.name}-final"
  vpc_security_group_ids = [
    var.security_group,
  ]
  db_subnet_group_name = aws_db_subnet_group.main.name
  publicly_accessible  = var.publicly_accessible
  skip_final_snapshot  = false
  tags                 = local.tags

  lifecycle {
    ignore_changes = [
      password,
    ]
  }
}
