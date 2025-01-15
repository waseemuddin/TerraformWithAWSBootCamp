provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}



resource "aws_vpc" "mycustom-vpc" {
    cidr_block = var.myapp-vpc
    tags= {
        Name: "${var.env_prefix}-cvpc"
    }

}

module "myapp-subnet" {
    source = "./modules/subnet"
    mysubnet = var.mysubnet
    avail_zone = var.avail_zone
    env_prefix = var.env_prefix
    vpc_id = aws_vpc.mycustom-vpc.id
    default_route_table_id = aws_vpc.mycustom-vpc.default_route_table_id
}

module "myapp-server" {
    source = "./modules/webserver"
    vpc_id = aws_vpc.mycustom-vpc.id
    my_ip = var.my_ip
    image_name = var.image_name
    public_key_location = var.public_key_location
    instance_type = var.instance_type
    subnet_id = module.myapp-subnet.subnet.id
    avail_zone = var.avail_zone
    env_prefix = var.env_prefix
}



