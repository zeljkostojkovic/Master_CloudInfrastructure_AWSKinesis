

resource "aws_s3_bucket" "click_stream_data_s3_bucket" {
  bucket = var.click_stream_data_s3_bucket
  force_destroy = true
}
