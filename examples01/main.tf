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
*/

 provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
 }

 resource "aws_vpc" "pro-machine-vpc" {
    cidr_block = "192.168.1.0/24"
    tags = {
       vpc_env:  "prod"
    }
 }

 resource "aws_subnet" "test_subnet-1" {
    vpc_id = aws_vpc.pro-machine-vpc.id
    cidr_block = "192.168.1.0/25"
    availability_zone = "us-east-1a"
    tags = {
      Name: "CVPC-subnet-1"
    }
 }

 data "aws_vpc" "existing_vpc" {
    default = "true"
 }

resource "aws_subnet" "test_subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.96.0/20"
    availability_zone = "us-east-1a"
    tags = {
      Name: "CPVC-subnet-2"
    }

}

