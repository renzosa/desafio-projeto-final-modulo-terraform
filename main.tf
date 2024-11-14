terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.75.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Environment = "Santander Coders 2024"
      Group       = "Terraform Test"
      Project     = "Ada - Modulo 5"
      Owner       = "Renzo Sá"
    }
  }
}
