

data "aws_vpc" "shared" {
  filter {
    name = "tag:Name"
    values= ["default"]
  }
}

data "aws_subnet" "shared" {
    filter {
        name ="tag:Name"
        values = ["subneta"]
    }
         vpc_id = data.aws_vpc.shared.id 
}

data "aws_ami" "amazon_linux-2" {
    most_recent = true
    owners = ["amazon"]

    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "Appserver" {
  ami           = data.aws_ami.amazon_linux-2.id
  instance_type = "t3.micro"
  subnet_id = data.aws_subnet.shared.id
  

  tags = {
    Name = "Webapp-Server"
  }
}