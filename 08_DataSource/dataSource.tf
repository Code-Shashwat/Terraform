data "aws_ami" "ubuntu" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
}

output "unbuntu-ami-data" {
  value = data.aws_ami.ubuntu.id
}

resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  root_block_device {
    volume_size = "10"
    volume_type = "gp3"
  }
  tags = {
    name = "My-EC2"
  }
}

data "aws_region" "my-region" {
  
}

data "aws_caller_identity" "current" {
  
}

data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = ["s3:GetObject"]

    resources = ["arn:aws:s3:::*/*"]
  }
}

data "aws_vpc" "my-vpc" {
  tags = {
    ENV = "PROD"
  }
}

output "vpc-details" {
  value = data.aws_vpc.my-vpc.id
}
output "region" {
  value = data.aws_region.my-region
}

output "x" {
  value = data.aws_caller_identity.current
}

output "policy" {
    value = data.aws_iam_policy_document.static_website.json
}