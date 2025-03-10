

# resource "aws_instance" "myprod-machine" {
#     ami = "ami-04b4f1a9cf54c11d0"
#     instance_type = "t2.micro"
#     tags = {
#       Name: "Production-machine"
#     }
# }

# variable "vpc_cidr_block" {
#   description = "vpc cidr block"
# }
variable "cidr_blocks" {
  description = "cidr blocks for vpc and subnet"
  //default = "10.0.10.0/24"
  type = list(object({
    cidr_block = string
    name = string
  }))
  
}
 

# variable "subnet_cidr_block" {
#   description = "subnet cidr block"
#   //default = "10.0.10.0/24"
#   type = list(sting)
# }
 
variable "environment" {
  description = "production"
}

resource "aws_vpc" "mycustom-vpc" {
  //cidr_block = "10.0.0.0/16"
    cidr_block = var.cidr_blocks[0].cidr_block
  //cidr_block = var.vpc_cidr_block
  //environment = var.environment
  tags = {
    Name: var.cidr_blocks[0].name
    }
}

resource "aws_subnet" "mycustom-subnet-1" {
  vpc_id = aws_vpc.mycustom-vpc.id
  //cidr_block = "192.168.1.0/24"
  //cidr_block = var.subnet_cidr_block  
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name: var.cidr_blocks[1].name
  }
}

# data "aws_vpc" "existing_vpc2" {
#   default = true
# }

# resource "aws_subnet" "mycustom-subnet-2" {
#     vpc_id = data.aws_vpc.existing_vpc2.id
#     cidr_block = "172 .31.96.0/24"
#     availability_zone = "us-east-1c"
# }

# resource "aws_s3_bucket" "example" {
#   bucket = "my-terraform-bucket"
#   acl    = "private"

# output "dev-vpc_id" {
#   value = aws_vpc.mycustom-vpc.id
# }


# output "dev-subnet-id" {
#   value = aws_subnet.mycustom-subnet-1.id
#    }
