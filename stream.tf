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

  tags = var.tags
}

resource "aws_kms_key" "stream_key" {
  description              = "Encrypts data within Kinesis stream, ${var.stream_name}"
  deletion_window_in_days  = 10
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = true

  tags = var.tags
}

resource "aws_kms_alias" "stream_key_alias" {
  name          = "alias/${var.stream_name}"
  target_key_id = aws_kms_key.stream_key.key_id
}
