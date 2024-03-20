resource "aws_iam_role" "cognito_sns" {
  name               = "${var.name}-sns"
  assume_role_policy = data.aws_iam_policy_document.cognito_sns_trust_policy.json
}

data "aws_iam_policy_document" "cognito_sns_trust_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cognito-idp.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "cognito_sns" {
  name   = "${var.name}-sns"
  role   = aws_iam_role.cognito_sns.name
  policy = data.aws_iam_policy_document.cognito_sns.json
}

data "aws_iam_policy_document" "cognito_sns" {
  statement {
    effect    = "Allow"
    actions   = ["sns:Publish"]
    resources = ["*"]
  }
}
