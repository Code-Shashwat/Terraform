variable "aws_instance_type" {
  type = string
  description = "This variable contain data about ec2 instance type"

  validation {
    condition = contains(["t2.micro","t3.micro"],var.aws_instance_type)
    error_message = "Only t2.micro and t3.micro is allowed"
  }
    
}

variable "aws_instance_volume_size" {
  type = number
  description = "This variable contain data about ec2 instance volume size"
}

variable "aws_instance_volume_type" {
  type = string
  description = "This variable contain data about ec2 instance volume type"
}

variable "ec2_volume_config" {
  type = object({
    size = string
    type = number
  })
  description = "The size and type of the root block volume for EC2 instances."

  default = {
    size = 10
    type = "gp3"
  }
}

variable "additional_tags" {
  type    = map(string)
  default = {}
}