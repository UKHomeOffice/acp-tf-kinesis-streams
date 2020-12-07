# resource "aws_iam_user" "kinesis_producer" {
#   name = "acp-kinesis-producer-${var.environment}"
#   path = "/"

#   tags = {
#     tag-key = "tag-value"
#   }
# }

# resource "aws_iam_access_key" "producer" {
#   user = aws_iam_user.kinesis_producer.name
# }

# resource "aws_iam_user_policy_attachment" "producer_policy" {
#   user       = aws_iam_user.kinesis_producer.name
#   policy_arn = aws_iam_policy.producer_policy.arn
# }

# resource "aws_iam_policy" "producer_policy" {
#   name        = "acp_kinesis_producer_polcy"
#   path        = "/"
#   description = "A policy to enable writing to the specified Kinesis Data Stream"

#   policy = data.aws_iam_policy_document.produce_kinesis_document.json
# }

# data "aws_iam_policy_document" "produce_kinesis_document" {
#   statement {
#     actions = [
#       "kinesis:PutRecord"
#     ]

#     resources = [
#       "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stream/${var.stream_name}"
#     ]
#   }
# }
