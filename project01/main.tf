provider "aws" {}

variable "vpc_cider_block" {}
variable "subnet_cidr_block" {}
variable "env_prefix" {}
variable "avail_zone" {}
variable "my_ip" {}
variable "instance_type" {}
variable "publlic_key_location" {}


resource "aws_vpc" "mycustom-vpc" {
  cidr_block = var.vpc_cider_block
  tags = {
    Name : "${var.env_prefix}-vpc"
  }

}
resource "aws_subnet" "mycustom-subnet-1" {
  vpc_id            = aws_vpc.mycustom-vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name : "${var.env_prefix}-subnet-1"
  }
}
# Custom Route Table
# resource "aws_route_table" "mycustom-route-table" {
#   vpc_id = aws_vpc.mycustom-vpc.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.mycustom-IGW.id
#   }
#   tags = {
#     Name : "${var.env_prefix}-rtb"
#   }
# }

#Custom Internet Gateway
resource "aws_internet_gateway" "mycustom-IGW" {
  vpc_id = aws_vpc.mycustom-vpc.id
  tags = {
    Name : "${var.env_prefix}-igws"
  }
}

#Default/Main Route Table
resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.mycustom-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mycustom-IGW.id
  }
  tags = {
    Name : "${var.env_prefix}-main-rtb"
  }

}
#Route Table Association
# resource "aws_route_table_association" "a-rtb-subnet" {
#     subnet_id = aws_subnet.mycustom-subnet-1.id
#     route_table_id = aws_route_table.mycustom-route-table.id
# }

#Default Security Group
resource "aws_default_security_group" "default-sg" {

  vpc_id = aws_vpc.mycustom-vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    //      cidr_block = ["39.60.165.76/32"]
    cidr_blocks = [var.my_ip]
  }
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    //      cidr_block = ["39.60.165.76/32"]
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
    Name : "${var.env_prefix}-defult-sg"
  }


}

#Custom Security Group

# resource "aws_security_group" "mycustom-sg" {
#     name = "mycustom-sg"
#     vpc_id= aws_vpc.mycustom-vpc.id

#     ingress {
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
# //      cidr_block = ["39.60.165.76/32"]
#         cidr_blocks = [var.my_ip]
#     }
#     ingress {
#         from_port = 8080
#         to_port = 8080
#         protocol = "tcp"
# //      cidr_block = ["39.60.165.76/32"]
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#         prefix_list_ids = []
#     }
#     tags = {
#         Name: "${var.env_prefix}-sg"
#     }


# }

data "aws_ami" "latest-amazon-linux-image" {
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
    value = data.aws_ami.latest-amazon-linux-image.id
}
output "ec2_public_ip" {
    value = aws_instance.mytest-server
    
}

resource "aws_key_pair" "ssh-key" {
    key_name = "your key name"
    public_key = file(var.publlic_key_location)

}

 resource "aws_instance" "mytest-server" {
     ami = data.aws_ami.latest-amazon-linux-image.id
     instance_type = var.instance_type
       
     subnet_id = aws_subnet.mycustom-subnet-1.id
     vpc_security_group_ids = [aws_default_security_group.default-sg.id]
     availability_zone = var.avail_zone
     associate_public_ip_address = true
    //key_name = "ans-key"
      key_name =aws_key_pair.ssh-key.key_name
      user_data = file("entry-script.sh")

     tags = {
      Name: "${var.env_prefix}-testserver"
     }



 }