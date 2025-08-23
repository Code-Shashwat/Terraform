ec2_instance_count=4
ec2_instance_config_list = [
  {
    instance_type = "t2.micro",
    ami           = "ubuntu"
  }
]

ec2_instance_config_map = {
  ubuntu_1 = {
    instance_type = "t2.micro"
    ami           = "ubuntu"
  }

  nginx_1 = {
    instance_type = "t2.micro"
    ami           = "nginx"
  }
}