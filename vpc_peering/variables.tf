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