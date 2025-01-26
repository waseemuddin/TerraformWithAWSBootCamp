provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "prod_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
     Name: "${var.vpc_name}"
     Owner = local.Owner
     costcenter = local.costcenter
     TeamDL = local.TeamDL
     environment : "${var.environments}"
  }
}

resource "aws_internet_gateway" "prod_IGW" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
     Name: "${var.vpc_name}-IGW"
    
  }
}




## To Store the Terraform state we use the AWS S3 bucket

terraform {
  backend "s3" {
    bucket = "myfun-bk"
    key    = "myfun-Infra.tfsate"
    region = "us-east-1"
  }
}





