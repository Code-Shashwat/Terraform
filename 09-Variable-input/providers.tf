terraform {
  required_version = ">1.0"
  required_providers {
    aws = {
      version = ">1.8"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}