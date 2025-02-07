
module "myapp-infra" {
    source = "../modules/mod_network"
    vpc_cidr_block = "192.168.0.0/16"
    vpc_name = "Dev-Env-"
    enviornment = "Development"
    public_subnet_cidr_block = "192.168.1.0/25"
    private_subnet_cidr_block = "192.168.128.0/25"
    avail_zone = "us-east-1a"
    natgw_id = module.dev_natgw_1.natgw_id
}

module "dev_natgw_1" {
    source = "../modules/mod_nat"
    public_subnet_id = module.myapp-infra.public_subnets_id_1
    vpc_name = module.myapp-infra.vpc_name
}