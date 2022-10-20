terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }

  required_version = ">= 1.3.2"
}

provider "aws" {
  profile    = "default"
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}