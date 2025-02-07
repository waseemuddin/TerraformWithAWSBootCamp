
module "dev_sg_1" {
    source = "../modules/mod_sg"
    vpc_name = module.myapp-infra.vpc_name
    vpc_id = module.myapp-infra.vpc_id
    enviornment = module.myapp-infra.enviornment
    service_ports = ["80","443", "445", "8080", "22", "3389"]
     
}