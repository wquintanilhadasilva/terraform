resource "aws_s3_bucket" "wedson-bucket" {
  bucket = "wedson-remote-state"
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.wedson-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}