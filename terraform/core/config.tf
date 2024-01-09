terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30.0"
    }

    random = {
      version = "~> 3.6"
      source  = "hashicorp/random"
    }
  }

  backend "s3" {
    region = "ap-northeast-3" # Common for all backend buckets
  }
}
