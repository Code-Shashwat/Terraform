terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "bucket_suffix" {
    byte_length = 6
  
}

resource "aws_s3_bucket" "my_bucket" {
    bucket = "My-Bucket-${random_id.bucket_suffix.hex}"
  
}

output "Bucket_Name" {
    value =  aws_s3_bucket.my_bucket.bucket
}