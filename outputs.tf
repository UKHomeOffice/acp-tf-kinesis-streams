output "consumer_access_key" {
  value = aws_iam_access_key.consumer[0].id
}

output "consumer_secret_key" {
  value = aws_iam_access_key.consumer[0].encrypted_secret
}

output "producer_access_key" {
  value = aws_iam_access_key.producer[0].id
}

output "producer_secret_key" {
  value = aws_iam_access_key.producer[0].encrypted_secret
}

output "cloudwatch_exporter_access_key" {
  value = aws_iam_access_key.cloudwatch_exporter[0].id
}

output "cloudwatch_exporter_secret_key" {
  value = aws_iam_access_key.cloudwatch_exporter[0].encrypted_secret
}
