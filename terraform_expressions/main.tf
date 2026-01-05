resource "aws_instance" "Appserver" {
  ami = "ami-0ff8a91507f77f867"
  count = var.instance_count
  instance_type = var.environment == "production" ? "t2.micro" : "t3.micro"
  tags = var.environment_tags
}

resource "aws_security_group" "dynamic_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

  tags = var.environment_tags
}

resource "ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.dynamic_sg.id
  cidr_ipv4         = ["10.0.0.0/16"]
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "egress_rule" "all_traffic_ipv4" {
  security_group_id = aws_security_group.dynamic_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}
