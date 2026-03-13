variable "aws_region" {

  type = string
  
}

variable "bucket_prefix" {

  type = string
  
}

variable "tags" {
  type = object({
    Environment = string
    created_by = string
    deployment = number 
  }
  
  )
  
}