resource "aws_kinesis_stream" "kinesis_data_stream" {
  name             = var.kinesis_data_stream
  shard_count      = 1
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "IncomingRecords",
    "OutgoingBytes",
    "OutgoingRecords"
  ]

  stream_mode_details {
    stream_mode = "PROVISIONED"
  }
}