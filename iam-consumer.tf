resource "aws_iam_user" "kinesis_consumer" {
  name = "acp-kinesis-consumer-${var.environment}"
  path = "/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "consumer" {
  user = aws_iam_user.kinesis_consumer.name
  pgp_key = data.aws_ssm_parameter.kinesis_users_public_key.value
}

resource "aws_iam_user_policy_attachment" "consumer_policy" {
  user       = aws_iam_user.kinesis_consumer.name
  policy_arn = aws_iam_policy.consumer_policy.arn
}

resource "aws_iam_policy" "consumer_policy" {
  name        = "acp_kinesis_consumer_polcy"
  path        = "/"
  description = "A policy to enable consuming from the specified Kinesis Data Stream"

  policy = data.aws_iam_policy_document.consume_kinesis_document.json
}

data "aws_iam_policy_document" "consume_kinesis_document" {
  statement {
    actions = [
      "kinesis:Get*",
      "kinesis:DescribeStream*",
      "kinesis:ListShards"
    ]

    resources = [
      "arn:aws:kinesis:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stream/${var.stream_name}"
    ]
  }

  statement {
    actions = [
      "kinesis:ListStreams"
    ]

    resources = [
      "arn:aws:kinesis:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stream/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:CreateTable",
      "dynamodb:DescribeTable",
      "dynamodb:Scan",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.consumer_name}*"
    ]
  }
}
