output "newname" {
    value = local.formatted_project_name
  
}

output "port_list" {
 value = local.port_list  
}

output "sg_rules" {

    value = local.sg_rules
  
}

output "instance_size" {
    value = local.instance_size
  
}

output "instance_results" {

    value = var.instance_types
  
}