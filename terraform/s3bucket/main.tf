provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "satyam-s3-bucket" {
  bucket = "satyam-s3-bucket"
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.satyam-s3-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.satyam-s3-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}