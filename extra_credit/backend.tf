# S3 Backend Configuration for Terraform State File

terraform {
  backend "s3" {
    bucket         = "simple-time-service-terraform-state" # Replace with your unique bucket name
    key            = "terraform/state/simple-time-service.tfstate" # Path within the bucket to store state
    region         = "ap-south-1"  # The region where the S3 bucket will reside
    dynamodb_table = "simple-time-service-locks"  # DynamoDB table for state locking
  }
}
