module "dev_network_isb_1" {
  source             = "../modules/network"
  vpc_cidr           = "10.90.0.0/16"
  vpc_name           = "Dev_Env_VPC"
  environment        = "Development"
  public_cidr_block  = ["10.90.1.0/24", "10.90.2.0/24", "10.90.3.0/24"]
  private_cidr_block = ["10.90.10.0/24", "10.90.20.0/24", "10.90.30.0/24"]
  avail_zone         = ["us-east-1a", "us-east-1c", "us-east-1d"]
  natgw_id           = module.dev_natgw_1.natgw_id

}


module "dev_natgw_1" {
  source           = "../modules/nat"
  public_subnet_id = module.dev_network_isb_1.public_subnets_id_1
  vpc_name         = module.dev_network_isb_1.vpc_name
}