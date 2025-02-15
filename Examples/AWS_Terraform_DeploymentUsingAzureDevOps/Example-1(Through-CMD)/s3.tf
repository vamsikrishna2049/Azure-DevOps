# Create an S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "practisedomain.cloud" # Ensure this name is unique globally
}

# Enable versioning on the S3 bucket
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
