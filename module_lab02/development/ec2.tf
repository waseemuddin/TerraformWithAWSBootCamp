
module "dev_ec2_instance" {
    source = "../modules/mod_ec2"
    amis = {
    us-east-1 = "ami-04505e74c0741db8d" # ubuntu 20.04 LTS
    us-east-2 = "ami-04505e74c0741db90" # ubuntu 20.04 LTS
    }
    aws_region = var.aws_region
    instance_type = "t2.micro"
    key_name  = "ans-key"
    iam_instance_profile = module.dev_iam_1.instprofile
    public_subnets = module.myapp-infra.public_subnets_id
    private_subnets = module.myapp-infra.private_subnets_id
    sg_id = module.dev_sg_1.sg_id
    vpc_name = module.myapp-infra.vpc_name
    enviornment = module.myapp-infra.enviornment
    

}


module "dev_iam_1" {
    source = "../modules/mod_iam"
    enviornment = module.myapp-infra.enviornment
    rolename = "myec2-ff"
    instanceprofilename = "myprofile_ec2-ff"

}