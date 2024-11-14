# S3 bucket for frontend
resource "aws_s3_bucket" "tf_frontend_bucket" {
  bucket = "${var.buckets_name}-frontend"
}

# Bucket policy to allow CloudFront access only
resource "aws_s3_bucket_policy" "frontend_policy" {
  bucket     = aws_s3_bucket.tf_frontend_bucket.id
  depends_on = [aws_cloudfront_distribution.frontend_distribution]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontOnly"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.tf_frontend_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.frontend_distribution.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "frontend_access" {
  bucket = aws_s3_bucket.tf_frontend_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_frontend_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
