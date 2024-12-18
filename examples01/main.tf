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


//////////////////////////////////////// VPC and Subnet Class Example ///////////////////////////////////

 provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
 }

 resource "aws_vpc" "pro-machine-vpc" {
    cidr_block = "192.168.1.0/24"
    tags = {
      Name: "CVPC"
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

output "dev-vpc-id" {
  value = aws_vpc.pro-machine-vpc.id
 }


output "dev-subnet-id" {
  value = aws_subnet.test_subnet-1.id
}

///////////////////////////////////////////////// Ends Here ///////////////////////////////////////////////////
*/



provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
 }

 variable "cidr_blocks" {   // 1st way to define vailable but but not much efficientl  and 2nd why to define the vailable using "terraform apply -var "subnet-cidr-block=192.168.1.0/25"    availability_zone = "us-east-1a"
   //description = "cidr blocks for vpc and subnets"
   description = "cidr blocks for vpc and subnets and tag names"
   
   //default = "192.168.1.0/25"
   // type = list(string)
    type = list(object({
          cidr_block = string
          Name = string  
   }))

 }
 //variable "subnet_cidr_block" {   // 1st way to define vailable but but not much efficientl  and 2nd why to define the vailable using "terraform apply -var "subnet-cidr-block=192.168.1.0/25"    availability_zone = "us-east-1a"
  // description = "subnet cidr block"
  // default = "192.168.1.0/25"
  // type = string
   
 //}
 
 variable "vpc_cidr_block" {  
  description = "cvpc cidr block"
 }

 variable "environment" {
  description = "testing environment"
 }

 resource "aws_vpc" "pro-machine-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
     // Name: var.environment
        Name: var.cidr_blocks[0].name
       vpc_env:  "prod"
    }
 }

 resource "aws_subnet" "test_subnet-1" {
    vpc_id = aws_vpc.pro-machine-vpc.id
    cidr_block = var.cidr_blocks[1].cidr_block  //subnet cider block using variable
    tags = {
      Name: var.cidr_blocks[1].name 
     // Name: "CVPC-subnet-1"
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

output "dev-vpc-id" {
  value = aws_vpc.pro-machine-vpc.id
 }


output "dev-subnet-id" {
  value = aws_subnet.test_subnet-1.id
}

