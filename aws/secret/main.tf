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

data "aws_iam_policy_document" "main" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = [
      aws_secretsmanager_secret.main.arn,
    ]
  }
}

resource "aws_iam_policy" "main" {
  name   = "read-secret-${aws_secretsmanager_secret.main.name}"
  policy = data.aws_iam_policy_document.main.json
}
