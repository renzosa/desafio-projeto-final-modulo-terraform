resource "aws_s3_bucket" "tf-bucket-application" {
  bucket = "tf-bucket-application-renzo-santander-coders-2024-by-ada"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf-bucket-application.id
  versioning_configuration {
    status = "Enabled"
  }
}
