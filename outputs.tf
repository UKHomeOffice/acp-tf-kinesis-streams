output "consumer_access_key" {
  value = aws_iam_access_key.consumer.*.id
}

output "consumer_secret_key" {
  value = aws_iam_access_key.consumer.*.encrypted_secret
}

output "producer_access_key" {
  value = aws_iam_access_key.producer.*.id
}

output "producer_secret_key" {
  value = aws_iam_access_key.producer.*.encrypted_secret
}

output "cloudwatch_exporter_access_key" {
  value = aws_iam_access_key.cloudwatch_exporter.*.id
}

output "cloudwatch_exporter_secret_key" {
  value = aws_iam_access_key.cloudwatch_exporter.*.encrypted_secret
}

output "stream_arn" {
  value = aws_kinesis_stream.stream.arn
}

output "stream_key" {
 value =  aws_kms_key.stream_key.arn
}