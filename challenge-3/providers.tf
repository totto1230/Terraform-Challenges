terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key = "AKIA4MTWHVKZBKUPDGN5"
  secret_key = "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"
  region = "us-east-1"
}