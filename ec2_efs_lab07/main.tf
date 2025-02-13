//AWS Provider 
provider "aws" {
  region = var.aws_region
}

//VPC module 
module "vpc" {
  source         = "./modules/vpc"
  vpc_name       = "efs-vpc"
  vpc_cidr_block = var.vpc_cidr_block
  avail_zone     = var.avail_zone
  public_subnets = var.public_subnets
  aws_region     = var.aws_region
}

//Security group module
module "security_groups" {
  source        = "./modules/sg"
  vpc_name      = "efs-vpc"
  vpc_id        = module.vpc.vpc_id
  service_ports = ["80", "443", "445", "8080", "22", "3389"]
}

//EC2 module
module "ec2" {
  source        = "./modules/ec2"
  instance_type = "t2.micro"
  image_name    = var.image_name
  aws_region    = var.aws_region
  key_name      = "Keyname????"
  vpc_name      = "efs-vpc"
  public_subnets = module.vpc.public_subnets
  ec2_sg_id     = module.security_groups.ec2_sg_id
  efs_id        = module.efs.efs_id
  instance_name = "EFS-Example-Instance"
//ec2_sg_id     = module.security_groups.myapp-efs-sg
//subnet_id     = module.vpc.public_subnets[0]
//subnet_id = module.vpc.public_subnets[count.index]
}

//EFS module
module "efs" {
source = "./modules/efs"
creation_token = "my-efs"
efs_name       = "MyEFS"
subnets        = module.vpc.public_subnets
efs_sg_id      = module.security_groups.efs_sg_id
}
