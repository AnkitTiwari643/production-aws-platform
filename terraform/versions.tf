terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # For interview demo you can comment this out to use local state.
  # For real use, create bucket + table first and uncomment.
  # backend "s3" {
  #   bucket         = "YOUR-TERRAFORM-STATE-BUCKET"
  #   key            = "production-aws-platform/terraform.tfstate"
  #   region         = "ap-south-1"
  #   encrypt        = true
  #   dynamodb_table = "terraform-locks"
  # }
}
