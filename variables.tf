variable "common_tags" {
  description = "This is to help you add tags to your cloud objects"
  type        = map
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
