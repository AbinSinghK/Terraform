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
    name = "security_group"
    dynamic "ingress_value" {
        for_each = var.ingress_rules
        cidr_ipv4         = ingress_value.value.cidr_blocks
        from_port         = ingress_value.value.from_port
        ip_protocol       = ingress_value.value.protocol
        to_port           = ingress_value.value.to_port
    }
  
}


