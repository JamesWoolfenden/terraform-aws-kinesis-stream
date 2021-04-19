# tfsec:ignore:AWS024
resource "aws_kinesis_stream" "flow" {
  name             = var.stream["name"]
  shard_count      = var.stream["shard_count"]
  retention_period = var.stream["retention_period"]

  shard_level_metrics = var.stream["shard_level_metrics"]

  encryption_type = var.encryption_type
  kms_key_id      = var.kms_key_id

  tags = var.common_tags
}
