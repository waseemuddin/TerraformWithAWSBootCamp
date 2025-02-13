terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket222"
    key    = "path/to/terraform.tfstate"
    region = "us-east-1"
  }
}

