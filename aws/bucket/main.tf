data "aws_caller_identity" "current" {}

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

resource "aws_s3_bucket_ownership_controls" "main" {
  bucket = aws_s3_bucket.main.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = !var.public
  block_public_policy     = !var.public
  ignore_public_acls      = !var.public
  restrict_public_buckets = !var.public
}

resource "aws_s3_bucket_acl" "main" {
  depends_on = [
    aws_s3_bucket_ownership_controls.main,
    aws_s3_bucket_public_access_block.main,
  ]

  bucket = aws_s3_bucket.main.id
  acl    = (var.public) ? "public-read" : "private"
}

data "aws_iam_policy_document" "public_read" {
  statement {
    sid     = "PublicReadGetObject"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      "${aws_s3_bucket.main.arn}/*",
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

data "aws_iam_policy_document" "private_read_write" {
  statement {
    sid    = "PrivateReadWrite"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:Put*",
      "s3:List*",
      "s3:DeleteObject",
    ]
    resources = [
      "${aws_s3_bucket.main.arn}",
      "${aws_s3_bucket.main.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_s3_bucket_policy" "main" {
  bucket = aws_s3_bucket.main.id
  policy = (var.public) ? data.aws_iam_policy_document.public_read.json : data.aws_iam_policy_document.private_read_write.json

  depends_on = [aws_s3_bucket_public_access_block.main]
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
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
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
