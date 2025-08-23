terraform {
  required_version = ">1.7"
  required_providers {
    aws = {
      version = ">1.7"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}