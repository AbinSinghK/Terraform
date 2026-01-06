locals {
  formatted_project_name = lower(replace(var.project_name," ", "-"))
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket"

  tags = merge(var.default_tags,var.environment_tags)
}