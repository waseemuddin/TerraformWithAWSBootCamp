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

#AWS Provide Block
provider "aws" {
  region = "us-east-1"
}
# Ends AWS Provider Block

#Variable for c-vpc
variable "mycustom_vpc_cidr_block" {}
#Varilable for subnet
variable "mycustom_vpc_subnet1" {}
#Variable for AZ
variable avail_zone{}
#variable for env/tag names
variable env_prefix{}
variable my_ip{}
variable instance_type{}
variable public_key_location{}


#VPC Resource Block
resource "aws_vpc" "mycustom_vpc" {
      cidr_block = var.mycustom_vpc_cidr_block
      tags = {
        Name: "${var.env_prefix}-vpc"
      }
}

#Subnet Resource Block
resource "aws_subnet" "mycustom_subnet-1" {
        vpc_id = aws_vpc.mycustom_vpc.id
        cidr_block = var.mycustom_vpc_subnet1
        availability_zone = var.avail_zone
        tags = {
          Name: "${var.env_prefix}-subnet-1"
        }
}


/*resource "aws_route_table" "mycustom_vpc-route_table" {
    vpc_id = aws_vpc.mycustom_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mycustom_vpc_igw.id
    }
        tags = {
          Name: "${var.env_prefix}-rtb"
        }
   
}
*/

resource "aws_internet_gateway" "mycustom_vpc_igw" {
    vpc_id = aws_vpc.mycustom_vpc.id
    tags = {
          Name: "${var.env_prefix}-igw"
        }
}

//resource "aws_route_table_association" "a-rtb-subnet" {
    //  subnet_id = aws_subnet.mycustom_subnet-1.id
 //     route_table_id = aws_route_table.mycustom_vpc-route_table.id
      
//}

resource "aws_default_route_table" "main-rtb" {
    default_route_table_id = aws_vpc.mycustom_vpc.default_route_table_id

     route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mycustom_vpc_igw.id
    }
        tags = {
          Name: "${var.env_prefix}-main-rtb"
        }
   
}


/*resource "aws_security_group" "mycustom-sg" {
    name = "mycustom-sg"
    vpc_id = aws_vpc.mycustom_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
          Name: "${var.env_prefix}-sg"
        }
   

}
*/

resource "aws_default_security_group" "default-sg" {
    vpc_id = aws_vpc.mycustom_vpc.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
          Name: "${var.env_prefix}-default-sg"
        }
   

}


data "aws_ami" "latest_amazon-linux-image" {
      most_recent = true
      owners = ["amazon"]
      filter {
          name = "name"
          values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }
      filter {
          name = "virtualization-type"
          values = ["hvm"]

      }
}
output "aws_ami_id" {
    value  = data.aws_ami.latest_amazon-linux-image.id
} 

output "ec2_public_ip" {
    value  = aws_instance.myapp-server.public_ip
} 

resource "aws_key_pair" "ssh-key" {
      key_name = "server-key"
      public_key = "${file(var.public_key_location)}"

}

resource "aws_instance" "myapp-server" {
        ami = data.aws_ami.latest_amazon-linux-image.id
        instance_type = var.instance_type

        subnet_id = aws_subnet.mycustom_subnet-1.id
        vpc_security_group_ids = [aws_default_security_group.default-sg.id]
        availability_zone = var.avail_zone 

        associate_public_ip_address = true
        //key_name = "myckey"
        key_name = aws_key_pair.ssh-key.key_name

        user_data = file("entry-script.sh")

      
         tags = {
          Name: "${var.env_prefix}-server"
        }
}





///////////////////////////////////////////// *** AWS Lab - Varilables, VPC, Subnet Tags, Output *** ////////////////////////////////////////////
/*

provider "aws" {
    //region = "us-east-1"     for best practice use in  global credentials 
    //access_key = ""  
    //secret_key = ""
}

//variable "vpc_cidr_block" {
 // description = "vpc cidr block"
//}

variable "cidr_blocks" {
      description = "vpc and subnet cidr blocks"
      //type = list(string)
      type = list(object({
      cidr_block = string
      name = string

      }))
}

//variable "environment" {
 // description = "CVPC"
//}

resource "aws_vpc" "mynetwork_vpc" {
        // cidr_block = "192.168.1.0/24"
        //cidr_block = var.vpc_cidr_block
        //cidr_block = var.cidr_blocks[0]
          cidr_block = var.cidr_blocks[0].cidr_block
    
      tags = {
        //Name: "CVPC"
        //Name: var.environment
          Name: var.cidr_blocks[0].name
        //vpc_env: "mynetwork-vpc"
      }
}

 // variable "subnet_cidr_block" {
  //    description = "subnet cidr block 1"
  //    default = "192.168.1.0/25"
   //   type = string
//}

//variable avail_zone{}   // this is used and define for global environment varialble  "export TF_VAR_avail_zone=us-east-1c"

resource "aws_subnet" "mynetwork_subnet-1" {

        vpc_id = aws_vpc.mynetwork_vpc.id
        //cidr_block = var.subnet_cidr_block
        //cidr_block = "192.168.1.0/25"
        //cidr_block = var.cidr_blocks[1]
        cidr_block = var.cidr_blocks[1].cidr_block

        availability_zone = "us-east-1b"
        //  availability_zone = var.avail_zone
        tags = {
          //Name: "C-Subnet-1"
          Name: var.cidr_blocks[1].name
        }
}

data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet" "existing_vpc_subnet-2" {
      vpc_id = data.aws_vpc.existing_vpc.id
      cidr_block = "172.31.96.0/20"
      availability_zone = "us-east-1a"
      tags = {
        Name: "C-Subnet-2"
      }
}

output "mynetwork_vpc-id"{
    value = aws_vpc.mynetwork_vpc.id
}

output "mynetwork_subnet-id" {
    value = aws_subnet.mynetwork_subnet-1.id
}
*/

///////////////////////////////////////////// *** AWS Lab - Varilables, VPC, Subnet Tags, Output *** ////////////////////////////////////////////
/*
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
   //1 cidr_block = var.vpc_cidr_block
      cidr_block = var.cidr_blocks[0].cidr_block
      //2 cidr_block = var.cidr_blocks[0]
  
  
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
    //2cidr_block = var.cidr_blocks[1]
    //1cidr_block = var.subnet_cidr_block
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

*/
