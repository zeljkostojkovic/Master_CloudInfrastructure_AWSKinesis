provider "aws" {
  region = var.region
}

terraform {
  required_version = "=1.8.3"
  required_providers {
    aws = "~> 5.51.1"
  }
  backend "s3" {
    bucket         = "master-cloud-infrastructure-kinesis-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-east-1"
  }
}
