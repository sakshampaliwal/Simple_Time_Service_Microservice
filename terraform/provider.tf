terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
  
  # Authentication will be provided via environment variables or AWS CLI configuration
  # DO NOT hardcode credentials here
  
  default_tags {
    tags = var.tags
  }
}