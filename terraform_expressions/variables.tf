variable "environment_tags" {
    type = map(string)
    default = {
      Name = "Ec2-instance"
      Environment = "prod"
    }
  
}