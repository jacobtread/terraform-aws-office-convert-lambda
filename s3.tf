# Temporary bucket for the office converter lambda to use
resource "aws_s3_bucket" "bucket" {
  bucket = var.temporary_bucket_name
}

# Enforce a short 1 day lifecycle for objects within the temporary bucket
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    id     = "expire-after-1-day"
    status = "Enabled"

    filter {}

    expiration {
      days = 1
    }
  }
}
