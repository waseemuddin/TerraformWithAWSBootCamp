
provider "aws" {
  //region = "us-east-1"
  //access_key = ""
  //secret_key = ""
}

#Variables
variable mycustom_vpc_cidr_block{}
variable mycustom_vpc_subnet1 {}
variable env_prefix{}
variable avail_zone {}
variable my_ip{}
variable instance_type{}
variable public_key_location {}


#VPC Block

resource "aws_vpc" "mycustom_vpc" {
    cidr_block = var.mycustom_vpc_cidr_block
    tags = {
        Name: "${var.env_prefix}-vpc"
    }
}


#Subnet Block
resource "aws_subnet" "mycustom_subnet-1"{
    vpc_id = aws_vpc.mycustom_vpc.id
    cidr_block = var.mycustom_vpc_subnet1
    availability_zone = var.avail_zone 
    tags = {
      Name: "${var.env_prefix}-subnet-1"
    }
}

/*
resource "aws_route_table" "mycustom_vpc-route_table" {
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
  //    subnet_id = aws_subnet.mycustom_subnet-1.id
    //  route_table_id = aws_route_table.mycustom_vpc-route_table.id
//}

#default route table

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

##


/*
resource "aws_security_group" "mycustom-sg" {
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
    value = data.aws_ami.latest_amazon-linux-image.id
}

output "ec2_public_ip" {
    value = aws_instance.myapp-server.public_ip
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
      key_name = aws_key_pair.ssh-key.key_name
      
      user_data = file("entry-script.sh")

        tags = {
                Name:   "${var.env_prefix}-server"
        }

  }
  