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