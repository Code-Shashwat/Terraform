terraform {
  required_version = ">1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"
    alias = "ap-south"
}

provider "aws" {
    region = "eu-west-1"
    alias = "eu-west"
}

resource "aws_s3_bucket" "my_bucket_ap_south" {
    bucket = "my-bucket-ap-south-rtyuiop"
    provider = aws.ap-south
    
}

resource "aws_s3_bucket" "my_bucket_eu_west" {
    bucket = "my-bucket-eu-west-qwertygv"
    provider = aws.eu-west
  
}