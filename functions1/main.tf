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

positive_costs = [for cost in (var.monthly_costs) : abs(cost) ]
max_cost = max(local.positive_costs...)
min_cost = min(local.positive_costs...)
total_cost = sum(local.positive_costs)
avg_cost = local.total_cost / length(local.positive_costs)


current_timestamp = timestamp()
format1 = formatdate("YYYmmmddd",local.current_timestamp)
format2 = formatdate("YYY-MM-DD",local.current_timestamp)
timestamp_name = "backup-${local.format1}"

config_file_exists = fileexists("./config.json")
config_data = local.config_file_exists ? jsondecode(file("./config.json")) : {}


}

