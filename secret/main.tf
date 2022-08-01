resource "aws_secretsmanager_secret" "main" {
  name = "${var.project}-${var.environment}"
  tags = {
    Project     = var.project
    Environment = var.environment
    Domain      = var.domain
  }
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(merge(var.secrets...))
  lifecycle {
    ignore_changes = [
      secret_string,
      version_stages,
    ]
  }
}
