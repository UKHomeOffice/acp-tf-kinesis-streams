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

variable "environment" {
  type = string
}