resource "aws_iam_user" "main" {
  name = var.name
}

resource "aws_iam_user_policy_attachment" "main" {
  for_each = toset(var.policies)

  user       = aws_iam_user.main.name
  policy_arn = each.key
}
