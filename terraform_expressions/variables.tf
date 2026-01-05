variable "environment_tags" {
    type = map(string)
    default = {
      Name = "Ec2-instance"
      Environment = "prod"
    }
  
}

variable "environment" {
    type = string 
}

variable "instance" {
    type = list(string)
  
}

variable "instance_count" {
type = number
  
}