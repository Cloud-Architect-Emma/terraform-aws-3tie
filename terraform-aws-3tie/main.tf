terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "remote" {  # For Terraform Cloud
    organization = "your-org"
    workspaces {
      name = "aws-3tier"
    }
  }
  # Alternative: S3 backend
  # backend "s3" {
  #   bucket = "my-terraform-state-bucket"
  #   key    = "terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = var.region  # We'll define this in variables.tf
}
