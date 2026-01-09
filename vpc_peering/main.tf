resource "aws_vpc" "primary_vpc" {
  provider = aws.primary
  cidr_block       = var.primary_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = var.tags
}

resource "aws_vpc" "secondary_vpc" {
  provider = aws.secondary
  cidr_block       = var.secondary_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = var.tags
}

resource "aws_subnet" "primary_subnet" {
  provider = aws.primary
  vpc_id     = aws_vpc.primary_vpc.id
  cidr_block = var.primary_subnet_cidr
  availability_zone = data.aws_availability_zones.primary.names[0]
  map_public_ip_on_launch = true

  tags = var.tags
}

resource "aws_subnet" "secondary_subnet" {
  provider = aws.secondary
  vpc_id     = aws_vpc.secondary_vpc.id
  cidr_block = var.secondary_subnet_cidr
  availability_zone = data.aws_availability_zones.secondary.names[0]
  map_public_ip_on_launch = true

  tags = var.tags
}

resource "aws_internet_gateway" "primary_igw" {
  provider = aws.primary
  vpc_id = aws_vpc.primary_vpc.id

  tags = var.tags
}

resource "aws_internet_gateway" "secondary_igw" {
  provider = aws.secondary
  vpc_id = aws_vpc.secondary_vpc.id

  tags = var.tags
}

resource "aws_route_table" "primary_rt" {
  provider = aws.primary
  vpc_id = aws_vpc.primary_vpc.id

  route {
    cidr_block = var.primary_subnet_cidr
    gateway_id = aws_internet_gateway.primary_igw.id
  }

  tags = var.tags
}

resource "aws_route_table" "secondary_rt" {
  provider = aws.secondary
  vpc_id = aws_vpc.secondary_vpc.id

  route {
    cidr_block = var.secondary_subnet_cidr
    gateway_id = aws_internet_gateway.secondary_igw.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "primary_rta" {
  provider = aws.primary
  subnet_id      = aws_subnet.primary_subnet.id
  route_table_id = aws_route_table.primary_rt.id
}

resource "aws_route_table_association" "secondary_rta" {
  provider = aws.secondary
  subnet_id      = aws_subnet.secondary_subnet.id
  route_table_id = aws_route_table.secondary_rt.id
}

resource "aws_vpc_peering_connection" "primary_to_secondary" {
  provider = aws.primary
  peer_vpc_id   = aws_vpc.secondary_vpc.id
  vpc_id        = aws_vpc.primary_vpc.id
  peer_region   = var.secondary_region
  auto_accept = false
  tags = var.tags
}

resource "aws_vpc_peering_connection_accepter" "secondary_accepter" {
  provider = aws.secondary
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id
  auto_accept = true
  tags = var.tags
}

resource "aws_route" "primary_to_secondary" {
  provider = aws.primary
  route_table_id            = aws_route_table.primary_rt.id
  destination_cidr_block    = var.secondary_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [ aws_vpc_peering_connection_accepter.secondary_accepter ]
}

resource "aws_route" "secondary_to_primary" {
  provider = aws.secondary
  route_table_id            = aws_route_table.secondary_rt.id
  destination_cidr_block    = var.primary_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.primary_to_secondary.id

  depends_on = [ aws_vpc_peering_connection_accepter.secondary_accepter ]
}


resource "aws_security_group" "primary_sg" {
  provider    = aws.primary
  name        = "primary-vpc-sg"
  description = "Security group for Primary VPC instance"
  vpc_id      = aws_vpc.primary_vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from Secondary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.secondary_cidr_block]
  }

  ingress {
    description = "All traffic from Secondary VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.secondary_cidr_block]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

# Security Group for Secondary VPC EC2 instance
resource "aws_security_group" "secondary_sg" {
  provider    = aws.secondary
  name        = "secondary-vpc-sg"
  description = "Security group for Secondary VPC instance"
  vpc_id      = aws_vpc.secondary_vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP from Primary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.primary_cidr_block]
  }

  ingress {
    description = "All traffic from Primary VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.primary_cidr_block]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_instance" "primary_instance" {
  provider               = aws.primary
  ami                    = data.aws_ami.primary_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.primary_subnet.id
  vpc_security_group_ids = [aws_security_group.primary_sg.id]
  key_name               = var.primary_key_name

  user_data = local.primary_user_data

  tags = var.tags

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}

# EC2 Instance in Secondary VPC
resource "aws_instance" "secondary_instance" {
  provider               = aws.secondary
  ami                    = data.aws_ami.secondary_ami.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.secondary_subnet.id
  vpc_security_group_ids = [aws_security_group.secondary_sg.id]
  key_name               = var.secondary_key_name

  user_data = local.secondary_user_data

  tags = var.tags

  depends_on = [aws_vpc_peering_connection_accepter.secondary_accepter]
}