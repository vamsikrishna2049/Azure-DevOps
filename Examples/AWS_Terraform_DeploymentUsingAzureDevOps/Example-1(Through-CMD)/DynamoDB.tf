# Create a DynamoDB table for Terraform state locking
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "practisedomain.cloud" # Change the table name if needed
  billing_mode = "PAY_PER_REQUEST"      # Uses on-demand pricing
  hash_key     = "LockID"               # Primary key
  attribute {
    name = "LockID"
    type = "S"
  }
  point_in_time_recovery {
    enabled = true # Enables point-in-time recovery for backup
  }
  tags = {
    Name = "Terraform State Lock Table"
  }
}
