//Lab - 01 Terraform Basic
##
provider "aws" {
  region = "us-east-1"
  //access_key = ""
  //secret_key = ""
}

resource "aws_vpc" "my-cvpc" {

  cidr_block = "192.168.0.0/16"
  tags = {
    Name : "C-VPC Block"
  }
}

resource "aws_subnet" "aws_subnet-1" {

  vpc_id            = aws_vpc.my-cvpc.id
  cidr_block        = "192.168.1.0/25"
  availability_zone = "us-east-1a"
  tags = {
    Name : "C-Subnet-1"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "ex-subnet-2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = "172.31.96.0/20"
  availability_zone = "us-east-1c"
  tags = {
    Name : "C-Subnet-2"
  }
}

Printed out the output value while terraform apply command.
output "dev-vpc_id" {
  value = aws_vpc.my-cvpc.id
}


output "dev-subnet_id" {
  value = aws_subnet.aws_subnet-1.id
}

