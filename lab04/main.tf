provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

variable "myvpc" {}
variable "mysubnet" {}
variable "env_prefix" {}
variable "avail_zone" {}
variable "my_ip" {}

resource "aws_vpc" "custom-vpc" {
  cidr_block = var.myvpc
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "custom-subnet" {

  vpc_id            = aws_vpc.custom-vpc.id
  cidr_block        = var.mysubnet
  availability_zone = var.avail_zone
  tags = {
    Name : "${var.env_prefix}-subnet1"
  }
}

resource "aws_route_table" "main-rtb" {
  //name = "name" 
  vpc_id = aws_vpc.custom-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom_igw.id
  }
  tags = {
    Name : "${var.env_prefix}-rtb"
  }
}

/*
resource "aws_route_table" "custom-rtb" {
        //name = "name"
        vpc_id = aws_vpc.custom-vpc.id
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.custom_igw.id
        }
        tags = {
            Name: "${var.env_prefix}-rtb"
        }
}
*/

resource "aws_internet_gateway" "custom_igw" {
  vpc_id = aws_vpc.custom-vpc.id
  tags = {
    Name : "${var.env_prefix}-igw"
  }
}
/*
resource "aws_route_table_association" "a" {
    subnet_id      = aws_subnet.custom-subnet.id
    route_table_id = aws_route_table.custom-rtb.id

}
*/

resource "aws_security_group" "default-sg" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]

  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
  tags = {
    Name : "${var.env_prefix}-sg"
  }



}