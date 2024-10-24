resource "aws_iam_user" "main" {
  name = var.name
  tags = var.tags
}

resource "aws_iam_user_policy_attachment" "main" {
  count = length(var.policies)

  user       = aws_iam_user.main.name
  policy_arn = var.policies[count.index]
}

resource "aws_iam_user_group_membership" "main" {
  user = aws_iam_user.main.name

  groups = var.groups
}
