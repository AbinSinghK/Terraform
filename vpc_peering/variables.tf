variable "primary_region" {
    type = string
}

variable "secondary_region" {
    type = string
  
}

variable "tags" {
    type = object({
      name = string
      created_by = string
    })
  
}

variable "primary_cidr_block" {
    type = string 
}

variable "secondary_cidr_block" {
    type = string 
}

variable "instance_type" {
    type = string
  
}

variable "primary_key_name" {
  description = "Name of the SSH key pair for Primary VPC instance (us-east-1)"
  type        = string
  
}

variable "secondary_key_name" {
  description = "Name of the SSH key pair for Secondary VPC instance (us-west-2)"
  type        = string
  
}