

variable "region" {
    type = set(string)
    default = ["us-east-1", "us-west-2", "eu-west-1"]
}

variable "ec2_instance_type" {
    type = list(string)
    default = [ "t2.micro", "t2.small", "t3.small" ]
  
}


variable "environment_tags" {
    type = map(string)
    default = {
      Name = "Ec2-instance"
      Environment = "prod"
    }
  
}

variable "security_group_config" {
    type = tuple([ number,string,number ])
    default = [ 443, "tcp", 443 ]
  
}

variable "config" {
    type = object({
      region = string
      monitoring = bool
      instance_count = number
    })

    default = {
      region = "us-east-1"
      monitoring = true
      instance_count = 2
    }
  
}

variable "cidr_range" {

type = list(string)
default = ["10.0.0.0/16", "172.16.0.0/18","192.168.0.0/22"]
  
}