variable "stream_name" {
  type = string
}

variable "shard_count" {
  type = number
}

variable "retention_period" {
  type    = string
  default = 24
}

variable "encryption_type" {
  type    = string
  default = "KMS"
}

variable "kinesis_users_public_key_parameter_name" {
  type        = string
  description = "The name of the SSM parameter containing the public key for encrypting the AWS secret access key"
  default     = "kinesis-user-gpg-public-key"
}

variable "consumer_name" {
  type        = string
  default     = "logstash"
  description = "The name of the consumer application, which will be the name given to the requisite DynamoDB table"
}

variable "consumer_user" {
  type        = bool
  description = "If set to true create a Kinesis Stream consumer user"
  default     = false

}

variable "producer_user" {
  type        = bool
  description = "If set to true create a Kinesis Stream producer user"
  default     = false
}

variable "exporter_user" {
  type        = bool
  description = "If set to true create a Cloudwatch exporter user"
  default     = false

}

variable "tags" {
  type = map(string)
}