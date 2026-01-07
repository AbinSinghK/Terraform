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

output "monthly_costs" {

    value = var.monthly_costs
  
}

output "positive_costs" {

    value = local.positive_costs
  
}

output "max_cost" {

    value = local.max_cost
  
}

output "min_cost" {

    value = local.min_cost
  
}

output "total_cost" {

    value = local.total_cost
  
}

output "avg_cost" {

    value = local.avg_cost
  
}

output "timme" {

    value = local.current_timestamp
  
}

output "timestamp_name" {

    value = local.timestamp_name
  
}

output "config" {

    value = local.config_data
  
}