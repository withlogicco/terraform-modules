resource "aws_ecr_repository" "main" {
  name = var.name
  tags = var.tags
}

data "aws_iam_policy_document" "read_only" {
  statement {
    sid = "AllowECRPull"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]
    resources = [aws_ecr_repository.main.arn]
    effect    = "Allow"
  }

  statement {
    sid       = "AllowToken"
    actions   = ["ecr:GetAuthorizationToken"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "read_only" {
  name        = "ecr-${aws_ecr_repository.main.name}-read-only"
  description = "Allow pulling ECR repo ${aws_ecr_repository.main.name}"
  policy      = data.aws_iam_policy_document.read_only.json
}

data "aws_iam_policy_document" "read_write" {
  statement {
    sid = "AllowECRPushPull"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = [aws_ecr_repository.example.arn]
    effect    = "Allow"
  }

  statement {
    sid       = "AllowToken"
    actions   = ["ecr:GetAuthorizationToken"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_policy" "read_write" {
  name        = "ecr-${aws_ecr_repository.main.name}-read-write"
  description = "Allow pushing and pulling ECR repo ${aws_ecr_repository.main.name}"
  policy      = data.aws_iam_policy_document.read_write.json
}
