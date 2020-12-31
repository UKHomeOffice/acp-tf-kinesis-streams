resource "aws_iam_user" "cloudwatch_exporter" {
  name = "acp-kinesis-cloudwatch-exporter-${var.environment}"
  path = "/"

}

resource "aws_iam_access_key" "cloudwatch_exporter" {
  user = aws_iam_user.cloudwatch_exporter.name
  pgp_key = data.aws_ssm_parameter.kinesis_users_public_key.value
}

resource "aws_iam_user_policy_attachment" "cloudwatch_exporter_policy" {
  user       = aws_iam_user.cloudwatch_exporter.name
  policy_arn = aws_iam_policy.cloudwatch_exporter_policy.arn
}

resource "aws_iam_policy" "cloudwatch_exporter_policy" {
  name        = "acp_kinesis_cloudwatch_exporter_polcy"
  path        = "/"
  description = "A policy to enable gathering metrics about the specified Kinesis Data Stream"

  policy = data.aws_iam_policy_document.cloudwatch_exporter_document.json
}

data "aws_iam_policy_document" "cloudwatch_exporter_document" {

  statement {
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:List*",
      "cloudwatch:Get*"
    ]

    resources = [
      "arn:aws:kinesis:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stream/${var.stream_name}"
    ]
  }
}
