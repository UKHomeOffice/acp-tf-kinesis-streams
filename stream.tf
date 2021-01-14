resource "aws_kinesis_stream" "stream" {
  name             = var.stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_period
  encryption_type  = var.encryption_type
  kms_key_id       = aws_kms_key.stream_key.key_id

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingRecords",
    "IteratorAgeMilliseconds",
    "IncomingRecords",
    "ReadProvisionedThroughputExceeded",
    "WriteProvisionedThroughputExceeded",
    "OutgoingBytes"
  ]

  tags = {
    Environment = var.environment
  }
}

resource "aws_kms_key" "stream_key" {
  description             = "Encrypts data within Kinesis stream, ${var.stream_name}"
  deletion_window_in_days = 10
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation = true
  
  #policy = data.aws_iam_policy_document.stream_key_policy_document.json

  tags = {
    Environment = var.environment
  }
}

resource "aws_kms_alias" "stream_key_alias" {
  name          = "alias/${var.stream_name}"
  target_key_id = aws_kms_key.stream_key.key_id
}

# data "aws_iam_policy_document" "stream_key_policy_document" {

#   statement {
#     actions = [
#       "kms:*"
#     ]

#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
#     }

#     resources = [
#       "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${aws_kms_key.stream_key.key_id}"
#     ]
#   }
# }
