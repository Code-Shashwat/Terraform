locals {
  project  = "12-Multiple-resources"
  vpc_name = "${local.project}-vpc"
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
    nginx  = data.aws_ami.nginx.id
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = local.vpc_name
    Project = local.project
  }
}

resource "aws_subnet" "main" {
  count      = var.subnet_count
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id     = aws_vpc.main.id

  tags = {
    Name    = "subnet-${count.index}"
    Project = local.project
  }

}

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

data "aws_ami" "nginx" {
  most_recent = true

  filter {
    name   = "name"
    values = ["bitnami-nginx-1.25.4-*-linux-debian-12-x86_64-hvm-ebs-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "server" {
    for_each = var.ec2_instance_config_map
    ami = local.ami_ids[each.value.ami]
    instance_type = each.value.instance_type
    subnet_id = aws_subnet.main[0].id
    tags = {
    Name    = "${local.project}-${each.key}"
    Project = local.project
  }
}

output "project" {
  value = local.project
}

output "vpc_name" {
  value = local.vpc_name
}
