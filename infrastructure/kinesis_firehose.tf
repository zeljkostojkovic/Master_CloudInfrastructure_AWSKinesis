resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose_delivery_stream" {
  name        = var.kinesis_firehose_delivery_stream

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.kinesis_data_stream.arn
    role_arn           = aws_iam_role.kinesis_firehose_role.arn
  }

  destination = "extended_s3"
  extended_s3_configuration {
    file_extension = ".json"
    custom_time_zone = "UTC"

    dynamic_partitioning_configuration {
      enabled = "true"
    }

    processing_configuration {
      enabled = "true"

      processors {
        type = "MetadataExtraction"
        parameters {
          parameter_name  = "MetadataExtractionQuery"
          parameter_value = "{date:.date,action:.action}"
        }
        parameters {
          parameter_name  = "JsonParsingEngine"
          parameter_value = "JQ-1.6"
        }
      }
    }

    role_arn   = aws_iam_role.kinesis_firehose_role.arn
    bucket_arn = aws_s3_bucket.click_stream_data_s3_bucket.arn

    prefix = "data/date=!{partitionKeyFromQuery:date}/action=!{partitionKeyFromQuery:action}/"
    error_output_prefix = "error/"

    buffering_size = 64
    buffering_interval = 180
  }
}

resource "aws_iam_role" "kinesis_firehose_role" {
  name               = "kinesis_firehose_role"
  assume_role_policy = data.aws_iam_policy_document.kinesis_assume_role.json
}

data "aws_iam_policy_document" "kinesis_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = [
        "firehose.amazonaws.com",
        "kinesis.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "kinesis-full-access" {
  role       = aws_iam_role.kinesis_firehose_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}

resource "aws_iam_role_policy_attachment" "kinesis-firehose-full-access" {
  role       = aws_iam_role.kinesis_firehose_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFirehoseFullAccess"
}

resource "aws_iam_role_policy_attachment" "s3-full-access" {
  role       = aws_iam_role.kinesis_firehose_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}



