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
}

# resource "aws_s3_bucket" "example" {
#   bucket = local.formatted_bucket_name

#   tags = local.new_tag
# }

# resource "aws_security_group" "app_sg" {
#   name        = "app-security-group"
#   description = "security group with dynamic ports"
  

#   tags = local.new_tag
# }

# dynamic "ingress" {
#     for_each = {for rule in local.}
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = aws_vpc.main.cidr_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }


# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.allow_tls.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" 
# }
