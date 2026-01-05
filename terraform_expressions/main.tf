resource "aws_instance" "Appserver" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = var.environment == "production" ? "t2.micro" : "t3.micro"
  tags = var.environment_tags
}