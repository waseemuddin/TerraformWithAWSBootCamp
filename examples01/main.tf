/* This is the basic example of EC2 Machine using terrafrom script.
provider "aws"  {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "app_server" {
  ami           = ""
  instance_type = "t2.micro"

  tags = {
    Name = "Demomachine"
  }

}
/*
*/

//////////////////////////////////////// /// VPC and Subnet Class Example ///////////////////////////////////
// AWS Provider Block
provider "aws" {
    
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}

//AWS Resource Block for VPC

resource "aws_vpc" "mynetwork_vpc" {
      cidr_block = "192.168.1.0/24"
}

//AWS Resource Block for subnet -1

resource "aws_subnet" "mynetwork_subnet-1" {

    vpc_id = aws_vpc.mynetwork_vpc.id
    cidr_block = "192.168.1.0/25"
    availability_zone = "us-east-1a"
}

resource "aws_subnet" "mynetwork_subnet-2" {

    vpc_id = aws_vpc.mynetwork_vpc.id
    cidr_block = "192.168.1.128/25"
    availability_zone = "us-east-1b"
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "existing_vpc_subnet-3" {

    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.96.0/20"
    availability_zone = "us-east-1c"

}


