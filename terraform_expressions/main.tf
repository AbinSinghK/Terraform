resource "aws_instance" "Appserver" {
  ami = "ami-0ff8a91507f77f867"
  count = var.instance_count
  instance_type = var.environment == "production" ? "t2.micro" : "t3.micro"
  tags = var.environment_tags
}

resource "aws_security_group" "dynamic_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound and all outbound"
  tags        = var.environment_tags

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      cidr_blocks = ingress.value.cidr_blocks
      from_port   = ingress.value.from_port
      protocol = ingress.value.protocol
      to_port     = ingress.value.to_port
      
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



