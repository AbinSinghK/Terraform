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

output "bucket_naming" {
    value = var.bucket_naming
  
}

output "credential" {

    value = var.credential
    sensitive = true
  
}

output "all_locations" {

    value = local.all_locations
  
}

output "unique_locations" {

    value = local.unique_locations
  
}