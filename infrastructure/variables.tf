variable "region" {
  type = string
}

variable "kinesis_data_stream" {
  description = "Kinesis data stream name"
  type        = string
}

variable "kinesis_firehose_delivery_stream" {
  description = "Kinesis firehose delivery stream name"
  type        = string
}

variable "click_stream_data_s3_bucket" {
  description = "Bucket to collect click stream data from kinesis"
  type        = string
}
