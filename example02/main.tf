
provider "aws" {
  //region = "us-east-1"
  //access_key = ""
  //secret_key = ""
}

#VPC Block
resource "aws_vpc" "mycustom_vpc" {
    cidr_block = var.mycustom_vpc_cidr_block
    tags = {
        Name: "${var.env_prefix}-vpc"
    }
}


module "myapp-subnet" {
    source = "./modules/subnet"
    //mycustom_vpc_subnet1 = "10.0.10.0/24"
    mycustom_vpc_subnet1 = var.mycustom_vpc_subnet1
    avail_zone = var.avail_zone
    env_prefix = var.env_prefix
    vpc_id = aws_vpc.mycustom_vpc.id
    default_route_table_id = aws_vpc.mycustom_vpc.default_route_table_id

}

module "myapp-server" {
        source = "./modules/webserver"
        vpc_id =  aws_vpc.mycustom_vpc.id
        my_ip = var.my_ip
        image_name = var.image_name
        public_key_location = var.public_key_location
        instance_type = var.instance_type 
        subnet_id = module.myapp-subnet.subnet.id
        avail_zone = var.avail_zone
        env_prefix = var.env_prefix
}


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

