resource "aws_iam_policy" "policy" {
  name        = "acp_kinesis_writer_polcy"
  path        = "/"
  description = "A policy to enable writing to the specified Kinesis Data Stream"

  policy = data.aws_iam_policy_document.write_kinesis_document.json
}

data "aws_iam_policy_document" "write_kinesis_document" {
  statement {
    actions = [
      "kinesis:PutRecord"
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stream/${var.stream_name}"
    ]
  }
}
