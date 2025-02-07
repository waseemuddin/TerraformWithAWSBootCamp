provider "aws" {
  region = var.aws_region
}


terraform {
  backend "s3" {
    bucket = "development-app-bk"
    key    = "dev-Infra.tfstate"
    region = "us-east-1"
  }

}

