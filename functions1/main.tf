locals {
  formatted_project_name = lower(replace(var.project_name," ", "-"))
  new_tag = merge(var.default_tags,var.environment_tags)
  formatted_bucket_name = replace(replace(lower(substr(var.bucket_name, 0, 63))," ", ""), "!", "")
  port_list = split(",", var.allowed_ports)

  sg_rules = [ for port in local.port_list :
  
  {
    name = "port-${port}"
    port = port
    description = " Allow all traffic on port ${port}"
  }

  ]

instance_size = lookup(var.instance_sizes,var.environment,"t3.micro")

all_locations = concat(var.user_locations, var.default_locations)
unique_locations = toset(local.all_locations)

}


