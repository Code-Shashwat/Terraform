# Initialisation and selecting provider
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
        
    }   
  }
}
# Select Region
provider "aws" {
    region = "ap-south-1"
}

# Creating Resources
#Create VPC and set CIDR range and Tag
resource "aws_vpc" "VPC_1" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Terraform VPC"
    }
}
#create public subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.VPC_1.id
    cidr_block = "10.0.0.0/24"
  
}
#create private subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.VPC_1.id
    cidr_block = "10.0.1.0/24"
  
}

#create internet Gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.VPC_1.id
}

#Create Route table
resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.VPC_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate route table to subnet
resource "aws_route_table_association" "public_subnet" {
  route_table_id = aws_route_table.public_routetable.id
  subnet_id = aws_subnet.public_subnet.id
}



