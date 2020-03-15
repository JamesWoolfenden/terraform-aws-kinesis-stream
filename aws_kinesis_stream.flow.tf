resource "aws_kinesis_stream" "flow" {
  name             = var.stream["name"]
  shard_count      = var.stream["shard_count"]
  retention_period = var.stream["retention_period"]

  shard_level_metrics = var.stream["shard_level_metrics"]

  encryption_type = var.encryption_type
  kms_key_id      = var.kms_key_id

  tags = var.common_tags
}


variable "encryption_type" {
  type    = string
  default = "KMS"
}

variable "kms_key_id" {
  default = "alias/aws/kinesis"
}


variable "stream" {
  default = {
    name             = "terraform-kinesis-test"
    shard_count      = 1
    retention_period = 48

    shard_level_metrics = [
      "IncomingBytes",
      "OutgoingBytes",
    ]

    encryption_typ = "KMS"
  }
}
