
//*****Terraform Variable declearation*****/
vpc_name       = "C-VPC"
vpc_cidr_block = "10.0.0.0/16"
avail_zone     = ["us-east-1a", "us-east-1d"]
image_name     = "amzn2-ami-hvm-*-x86_64-gp2"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
aws_region     = "us-east-1"

//avail_zone = "us-east-1c"
//public_subnets = "10.0.1.0/24"
//vpc_name           = "dev_vpc_1"
