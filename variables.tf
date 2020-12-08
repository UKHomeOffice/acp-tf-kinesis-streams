variable "stream_name" {
  type = string
}

variable "shard_count" {
  type = number
}

variable "retention_period" {
  type = string
  default = 24
}

variable "encryption_type" {
  type = string
  default = "KMS"
}

variable "kms_key_id" {
  type = string
  default = "alias/aws/kinesis"
}

variable "environment" {
  type = string
}

variable "kinesis_users_public_key_parameter_name" {
  type = string
  description = "The name of the SSM parameter containing the public key for encrypting the AWS secret access key"
  default = "kinesis-user-gpg-public-key"
}
