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

variable "ec2_instance_type" {

type = list(string)
default = [ "t2.micro","t3.micro" ]
  
}