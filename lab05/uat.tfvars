
# myvpc           = "10.0.0.0/16"
# mysubnet        = "10.0.10.0/24"
# ami_id          = "ami-04b4f1a9cf54c11d0"
# instance_type   = "t2.micro"
# env_prefix      = "CVPC"
# avail_zone      = "us-east-1c"
# my_ip           = "39.60.180.153/32"
# myinstance_type = "t2.micro"


//aws_access_key = "xxxxxx"
//aws_secret_key = "yyyyyyy"
aws_region          = "us-east-1"
vpc_cidr            = "10.1.0.0/16"
public_subnet1_cidr = "10.1.1.0/24"
public_subnet2_cidr = "10.1.2.0/24"
public_subnet3_cidr = "10.1.3.0/24"
//private_subnet_cidr = "10.1.20.0/24"
vpc_name            = "terraform-aws-uat"
IGW_name            = "terraform-aws-igw"
public_subnet1_name = "Terraform_Public_Subnet1-uat"
public_subnet2_name = "Terraform_Public_Subnet2-uat"
public_subnet3_name = "Terraform_Public_Subnet3-uat"
//private_subnet_name = "Terraform_Private_Subnet-uat"
Main_Routing_Table = "Terraform_Main_table-testing"
key_name           = "a"
environment        = "dev"
env =  "uat"
//azs  = ["us-east-1a", "us-east-1c", "us-east-1d"]
