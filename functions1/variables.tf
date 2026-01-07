variable "project_name" {

    default = "Prjoject ALPHA Resource"
  
}

variable "default_tags" {

    default = {
        company = "awan"
        managed_by = "terraform"
    }
  
}

variable "environment_tags" {

default = {
    environment = "production"
    cost_center = "cc-128"
}

}

variable "bucket_name" {

    type = string

default = "ProjectAlphaStorageBucket with CAPS and Spaces!!!"
  
}

variable "allowed_ports" {

    type = string
    default = "80,443,8080,3306"
  
}

variable "instance_sizes" {

    default = {
        dev = "t2.micro"
        staging = "t3.small"
        prod = "t3.large"
    }
  
}

variable "environment" {
 default = "abin" 
}

variable "instance_types" {



    validation {
      condition = length(var.instance_types) >=2 && length(var.instance_types) <=20
      error_message = "Instance type must be between 2 - 20 Characters"
    }

    validation {
        condition = can(regex("^t[2-3]\\.",var.instance_types))
        error_message = "Instance type must start with t2 or t3"
  
    }
  
}

variable "bucket_naming" {

    type = string


    validation {
      condition = endswith(var.bucket_naming, "_backup")
      error_message = "bucket name must end with '_backup'"
    }
  
}

variable "credential" {

    type = string
    sensitive = true
  
}

variable "user_locations" {
    type = list(string)
    
  
}

variable "default_locations" {
    type = list(string)

  
}


variable "monthly_costs" {

    type = list(number)
    
  
}