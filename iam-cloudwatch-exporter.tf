resource "aws_iam_user" "cloudwatch_exporter" {
  count = var.exporter_user ? 1 : 0
  name  = "${var.stream_name}-cloudwatch-exporter"
  path  = "/"

  tags = var.tags

}

resource "aws_iam_access_key" "cloudwatch_exporter" {
  count   = var.exporter_user ? 1 : 0
  user    = aws_iam_user.cloudwatch_exporter[0].name
  pgp_key = data.aws_ssm_parameter.kinesis_users_public_key.value
}

resource "aws_iam_user_policy_attachment" "cloudwatch_exporter_policy" {
  count      = var.exporter_user ? 1 : 0
  user       = aws_iam_user.cloudwatch_exporter[0].name
  policy_arn = aws_iam_policy.cloudwatch_exporter_policy[0].arn
}

resource "aws_iam_policy" "cloudwatch_exporter_policy" {
  count       = var.exporter_user ? 1 : 0
  name        = "${var.stream_name}_cloudwatch_exporter_policy"
  path        = "/"
  description = "A policy to enable gathering metrics about the specified Kinesis Data Stream"

  policy = data.aws_iam_policy_document.cloudwatch_exporter_document.json
}

data "aws_iam_policy_document" "cloudwatch_exporter_document" {

  statement {
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:List*",
      "cloudwatch:Get*",
      "tag:GetResources"
    ]

    resources = [
      "*"
    ]
  }
}
