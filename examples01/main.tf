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

// VPC Variable block
//variable "vpc_cidr_block" {
  //  description = "vpc cidr block"
  
//}

  variable "cidr_blocks"{  //this cidr block is for vpc and subnet
  description = "cidr block for vpc and subnets"
  //type = list(string)
    type = list(object({
    cidr_block = string
    name = string   
    }))

}

variable "environment" {
    description = "CVPC environment"
}

//AWS Resource Block for VPC
resource "aws_vpc" "mynetwork_vpc" {
   // cidr_block = var.vpc_cidr_block
      cidr_block = var.cidr_blocks[0].cidr_block
      //cidr_block = var.cidr_blocks[0]
  
  
    //  cidr_block = "192.168.1.0/24"
      tags = {
        Name: var.cidr_blocks[0].name
        //Name: var.environment
        //Name: "C-VPC",
        //vpc_env:  "dev"
      }
}

//variable "subnet_cidr_block"{  //this cidr block for subnet
  //description = "subnet cidr block - 1"
  //type = string
 // default = "192.168.1.0/25" // this is the default value if the subnet not found then default value called
//}



//AWS Resource Block for subnet -1
resource "aws_subnet" "mynetwork_subnet-1" {
   
    vpc_id = aws_vpc.mynetwork_vpc.id
      cidr_block = var.cidr_blocks[1].cidr_block
    //cidr_block = var.cidr_blocks[1]
    //cidr_block = var.subnet_cidr_block
    //  cidr_block = "192.168.1.0/25"
    
    availability_zone = "us-east-1a"
    tags = {
     Name: var.cidr_blocks[1].name
     // Name: "C-Subnet-1"
    }
}

//AWS Resource Block for subnet -2
resource "aws_subnet" "mynetwork_subnet-2" {
    vpc_id = aws_vpc.mynetwork_vpc.id
    cidr_block = "192.168.1.128/25"
    availability_zone = "us-east-1b"
    tags = {
      Name: "C-Subnet-2"
    }
}

//AWS Data Block used for defining the existing or calling the existing vpc
data "aws_vpc" "existing_vpc" {
  default = true
}

//AWS Resource Block to call the exising vpc-subnet -3
resource "aws_subnet" "existing_vpc_subnet-3" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.96.0/20"
    availability_zone = "us-east-1c"
    tags = {
      Name: "d-Subnet-3"
    }

}

// output block will display the output in command prompt
output "mynetwork_vpc-id" {
    value = aws_vpc.mynetwork_vpc.id
}

output "mynetwork_subnet-id"{
    value = aws_subnet.mynetwork_subnet-1.id
}

