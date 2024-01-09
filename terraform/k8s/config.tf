terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.30"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
    helm = {
      version = "~> 2.12"
      source  = "hashicorp/helm"
    }
  }

  backend "s3" {
    region = "ap-northeast-3" # Common for all backend buckets
  }
}
