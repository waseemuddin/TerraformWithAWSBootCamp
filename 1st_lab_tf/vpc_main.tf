

resource "aws_instance" "myprod-machine" {
    ami = "ami-04b4f1a9cf54c11d0"
    instance_type = "t2.micro"
    tags = {
      Name: "Production-machine"
    }
}

resource "aws_vpc" "mycustom-vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name: "Custom-vpc-1"
  }
}

resource "aws_subnet" "mycustom-subnet-1" {
  vpc_id = aws_vpc.mycustom-vpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name: "Custom-subnet-01"
  }
}

data "aws_vpc" "existing_vpc2" {
  default = true
}

resource "aws_subnet" "mycustom-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc2.id
    cidr_block = "172.31.96.0/24"
    availability_zone = "us-east-1c"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-bucket"
  acl    = "private"
}


