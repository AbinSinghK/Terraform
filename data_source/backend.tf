terraform {
  backend "s3" {
    bucket = "abinsinghka2001"
    key    = "abinsinghka2001/dev/terraform.state"
    region = "us-east-1"
  }
}
