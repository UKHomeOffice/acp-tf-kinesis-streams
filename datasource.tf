data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "kinesis_users_public_key" {
  name            = var.kinesis_users_public_key_parameter_name
  with_decryption = true
}
