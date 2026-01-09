primary_region = "us-east-1"
secondary_region = "us-east-2"
tags = {
  name = "VPC-Peering-Connection"
  created_by = "terraform"
}
primary_cidr_block = "10.0.0.0/16"
secondary_cidr_block = "10.1.0.0/16"
primary_subnet_cidr = "10.0.1.0/24"
secondary_subnet_cidr = "10.1.1.0/24"
instance_type = "t2.micro"
primary_key_name = "vpc-peering-primary"
secondary_key_name = "vpc-peering-secondary"