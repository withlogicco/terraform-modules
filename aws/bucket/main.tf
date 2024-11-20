resource "aws_s3_bucket" "main" {
  bucket = var.name
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = (var.versioning_enabled) ? "Enabled" : "Disabled"
  }
}

data "aws_iam_policy_document" "read_only" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]
    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*",
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "read_only" {
  name        = "s3-${var.name}-read-only"
  description = "Allow read-only actions on ${var.name} and its objects"
  policy      = data.aws_iam_policy_document.read_only.json
}

data "aws_iam_policy_document" "read_write" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*",
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "read_write" {
  name        = "s3-${var.name}-read-write"
  description = "Allow read and write operations on ${var.name} and its objects"
  policy      = data.aws_iam_policy_document.read_write.json
}
