
provider "aws" {
  region = "us-east-1"
  //access_key = ""
  //secret_key = ""
}
//Variables Defining Class
//1st way to define variable
# variable "subnet_cidr_block" {
#   description = "subnet cidr block"
#   //default = "10.0.10.0/24"
#   //type = list(string)
# }

variable "cidr_blocks" {
  description = "subnet cidr block"
  //default = "10.0.10.0/24"
  //type = list(string)
  type = list(object({
  cidr_block = string
  name = string
}))

}

# variable "vpc_cidr_block" {
#   description = "vpc cidr block"
# }
//2nd way to defining variables
//   terraform plan -var "subnet_cidr_block=10.0.1.0/24"///

# variable "environment" {
#   description = "deployment environment"

# }

resource "aws_vpc" "dev-vpc" {
  //cidr_block = var.vpc_cidr_block
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
 //   Name : var.environment
 Name: var.cidr_blocks[0].name
  }
}

resource "aws_subnet" "dev-subnet-01" {
  vpc_id            = aws_vpc.dev-vpc.id
  cidr_block        = var.cidr_blocks[1].cidr_block
  availability_zone = "us-east-1a"
}


# resource "aws_subnet" "dev-subnet-01" {
#   vpc_id            = aws_vpc.dev-vpc.id
#   cidr_block        = var.cidr_blocks[1]
#   availability_zone = "us-east-1a"
# }

# resource "aws_subnet" "dev-subnet-01" {
#   vpc_id            = aws_vpc.dev-vpc.id
#   cidr_block        = var.subnet_cidr_block
#   availability_zone = "us-east-1a"
# }



# //Lab - 01 Terraform Basic
# ##
# provider "aws" {
#   region = "us-east-1"
#   //access_key = ""
#   //secret_key = ""
# }

# resource "aws_vpc" "my-cvpc" {

#   cidr_block = "192.168.0.0/16"
#   tags = {
#     Name : "C-VPC Block"
#   }
# }

# resource "aws_subnet" "aws_subnet-1" {

#   vpc_id            = aws_vpc.my-cvpc.id
#   cidr_block        = "192.168.1.0/25"
#   availability_zone = "us-east-1a"
#   tags = {
#     Name : "C-Subnet-1"
#   }
# }

# data "aws_vpc" "existing_vpc" {
#   default = true
# }

# resource "aws_subnet" "ex-subnet-2" {
#   vpc_id            = data.aws_vpc.existing_vpc.id
#   cidr_block        = "172.31.96.0/20"
#   availability_zone = "us-east-1c"
#   tags = {
#     Name : "C-Subnet-2"
#   }
# }

# //Printed out the output value while terraform apply command.
# output "dev-vpc_id" {
#   value = aws_vpc.my-cvpc.id
# }


# output "dev-subnet_id" {
#   value = aws_subnet.aws_subnet-1.id
# }

