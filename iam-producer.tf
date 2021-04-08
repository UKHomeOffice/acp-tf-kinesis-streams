resource "aws_iam_user" "kinesis_producer" {
  count = var.producer_user ? 1 : 0
  name  = "${var.stream_name}-producer"
  path  = "/"

  tags = var.tags

}

resource "aws_iam_access_key" "producer" {
  count   = var.producer_user ? 1 : 0
  user    = aws_iam_user.kinesis_producer[0].name
  pgp_key = data.aws_ssm_parameter.kinesis_users_public_key.value
}

resource "aws_iam_user_policy_attachment" "producer_policy" {
  count      = var.producer_user ? 1 : 0
  user       = aws_iam_user.kinesis_producer[0].name
  policy_arn = aws_iam_policy.producer_policy[0].arn
}

resource "aws_iam_policy" "producer_policy" {
  count       = var.producer_user ? 1 : 0
  name        = "${var.stream_name}_producer_polcy"
  path        = "/"
  description = "A policy to enable writing to the specified Kinesis Data Stream"

  policy = data.aws_iam_policy_document.producer_kinesis_document.json
}

data "aws_iam_policy_document" "producer_kinesis_document" {

  statement {
    actions = [
      "kms:GenerateDataKey"
    ]

    resources = [
      "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${aws_kms_key.stream_key.key_id}"
    ]
  }

  statement {
    actions = [
      "kinesis:PutRecord",
      "kinesis:PutRecords",
      "kinesis:DescribeStream*",
      "kinesis:SubscribeToShard",
      "kinesis:RegisterStreamConsumer"
    ]

    resources = [
      "arn:aws:kinesis:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stream/${var.stream_name}"
    ]
  }
}

