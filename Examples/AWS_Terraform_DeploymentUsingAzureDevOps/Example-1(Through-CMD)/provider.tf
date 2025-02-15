provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "practisedomain.cloud"    # Replace with your S3 bucket name
    key            = "terraform/state.tfstate" # Path inside the bucket
    region         = "us-east-1"               # Replace with your AWS region
    dynamodb_table = "practisedomain.cloud"    # Replace with your S3 bucket name
  }
}
