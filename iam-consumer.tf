resource "aws_iam_user" "kinesis_consumer" {
  count = var.consumer_user ? 1 : 0
  name  = "${var.stream_name}-consumer"
  path  = "/"

  tags = var.tags

}

resource "aws_iam_access_key" "consumer" {
  count   = var.consumer_user ? 1 : 0
  user    = aws_iam_user.kinesis_consumer[0].name
  pgp_key = data.aws_ssm_parameter.kinesis_users_public_key.value
}

resource "aws_iam_user_policy_attachment" "consumer_policy" {
  count      = var.consumer_user ? 1 : 0
  user       = aws_iam_user.kinesis_consumer[0].name
  policy_arn = aws_iam_policy.consumer_policy[0].arn
}

resource "aws_iam_policy" "consumer_policy" {
  count       = var.consumer_user ? 1 : 0
  name        = "${var.stream_name}_consumer_polcy"
  path        = "/"
  description = "A policy to enable consuming from the specified Kinesis Data Stream"

  policy = data.aws_iam_policy_document.consume_kinesis_document.json
}

data "aws_iam_policy_document" "consume_kinesis_document" {

  statement {
    actions = [
      "cloudwatch:PutMetricData"
    ]

    resources = [
      "arn:aws:cloudwatch:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }

  statement {
    actions = [
      "kms:Decrypt"
    ]

    resources = [
      "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${aws_kms_key.stream_key.key_id}"
    ]
  }

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
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/${var.stream_name}*"
    ]
  }
}
