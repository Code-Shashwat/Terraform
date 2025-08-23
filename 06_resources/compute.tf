resource "aws_instance" "web" {
#   ami                         = "ami-021a584b49225376d"
  ami                         = "ami-0aed1c658e0f4d6d5"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  instance_type               = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.public_http_traffic.id ]
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
  lifecycle {
    
    create_before_destroy = true
  }
}

resource "aws_security_group" "public_http_traffic" {
    description = "This security group allow http traffic on port 80 and 443"
    name = "public-http-traffic"
    vpc_id = aws_vpc.main.id
    tags = merge(local.common_tags, {
    Name = "06-resources-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http" {
    cidr_ipv4 = "0.0.0.0/0"
    security_group_id = aws_security_group.public_http_traffic.id
    ip_protocol = "tcp"
    from_port = 80
    to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "https" {
    cidr_ipv4 = "0.0.0.0/0"
    security_group_id = aws_security_group.public_http_traffic.id
    ip_protocol = "tcp"
    from_port = 443
    to_port = 443
}