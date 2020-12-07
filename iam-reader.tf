resource "aws_iam_policy" "reader_policy" {
  name        = "acp_kinesis_reader_polcy"
  path        = "/"
  description = "A policy to enable reading from the specified Kinesis Data Stream"

  policy = data.aws_iam_policy_document.read_kinesis_document.json
}

data "aws_iam_policy_document" "read_kinesis_document" {
  statement {
    actions = [
      "kinesis:Get*",
      "kinesis:DescribeStreamSummary"
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stream/${var.stream_name}"
    ]
  }

  statement {
    actions = [
      "kinesis:ListStreams"
    ]

    resources = [
      "*"
    ]
  }
}
