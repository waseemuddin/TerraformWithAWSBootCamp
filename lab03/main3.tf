/* provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}

variable myapp-vpc {}
variable mysubnet {}
variable env_prefix {}
variable avail_zone {}
variable my_ip {}
variable instance_type {}
variable public_key_location{}

resource "aws_vpc" "mycustom-vpc" {
    cidr_block = var.myapp-vpc
    tags= {
        Name: "${var.env_prefix}-cvpc"
    }

}
resource "aws_subnet" "mycustom-subnet" {
        vpc_id = aws_vpc.mycustom-vpc.id
        cidr_block = var.mysubnet
        availability_zone = var.avail_zone
        tags = {
            Name: "${var.env_prefix}-subnet-1"
        }
}

resource "aws_default_route_table" "main-rtb" {
        default_route_table_id = aws_vpc.mycustom-vpc.default_route_table_id
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.mycustom-igw.id
        }
        tags = {
            Name: "${var.env_prefix}-rtb"
        }
}

resource "aws_internet_gateway" "mycustom-igw" {
        vpc_id = aws_vpc.mycustom-vpc.id
        tags = {
            Name: "${var.env_prefix}-igw"
        }
}


resource "aws_default_security_group" "default-sg" {
        vpc_id = aws_vpc.mycustom-vpc.id

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
        subnet_id = aws_subnet.mycustom-subnet.id
        instance_type = var.instance_type
        associate_public_ip_address = true
        key_name = aws_key_pair.ssh-key.key_name
        user_data = file("entry-script.sh")
        tags = {
            Name: "${var.env_prefix}-server"
        }
}
*/
