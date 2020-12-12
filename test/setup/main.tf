terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
}

variable "random_suffix" {
  type = string
}

resource "aws_s3_bucket" "ex_aws_test" {
  bucket = "ex-aws-test-${var.random_suffix}"

  tags = {
    "Description" = "This bucket is intended only for testing of ExAws and may be safely deleted when testing is complete."
  }
}
