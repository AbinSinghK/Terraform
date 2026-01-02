resource "aws_instance" "Appserver" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type =  tolist(var.ec2_instance_type)[1]
  region = var.region[2]
  count = var.config.instance_count
  monitoring = var.config.monitoring
  tags = var.environment_tags
}

resource "aws_security_group" "my_first" {
  name        = "securitygroup_terraform"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = var.environment_tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.myfirst.id
  cidr_ipv4         = var.cidr_range[0]
  from_port         = var.security_group_config[0]
  ip_protocol       = var.security_group_config[1]
  to_port           = var.security_group_config[2]
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_first.id
  cidr_ipv4         = var.cidr_range[1]
  ip_protocol       = "-1" # semantically equivalent to all ports
}
