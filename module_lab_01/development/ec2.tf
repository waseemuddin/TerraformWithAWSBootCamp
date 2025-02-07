
module "dev_isb_ec2" {
  source      = "../modules/ec2_instance"
  environment = module.dev_network_isb_1.environment
  amis = {
    us-east-1 = "ami-04b4f1a9cf54c11d0"
    us-east-2 = "ami-0e1bed4f06a3b463d"

  }
  aws_region           = var.aws_region
  instance_type        = "t2.micro"
  key_name             = "ans-key"
  iam_instance_profile = module.dev_iam_1.instprofile
  public_subnets       = module.dev_network_isb_1.public_subnets_id
  private_subnets      = module.dev_network_isb_1.private_subnets_id
  sg_id                = module.dev_isb_sg_1.sg_id
  vpc_name             = module.dev_network_isb_1.vpc_name
  elb_listener         = module.dev_elb_1.elb_listener
  elb_listener_public  = module.dev_elb_1_public.elb_listener

}


module "dev_elb_1" {
  source          = "../modules/elb"
  environment     = module.dev_network_isb_1.environment
  nlbname         = "dev-nlb"
  subnets         = module.dev_network_isb_1.public_subnets_id
  tgname          = "dev-nlb-tg"
  vpc_id          = module.dev_network_isb_1.vpc_id
  private_servers = module.dev_isb_ec2.private_servers

}

module "dev_elb_1_public" {
  source          = "../modules/elb"
  environment     = module.dev_network_isb_1.environment
  nlbname         = "dev-nlb-public"
  subnets         = module.dev_network_isb_1.public_subnets_id
  tgname          = "dev-nlb-tg-public"
  vpc_id          = module.dev_network_isb_1.vpc_id
  private_servers = module.dev_isb_ec2.public_servers

}

module "dev_iam_1" {
  source              = "../modules/iam"
  environment         = module.dev_network_isb_1.environment
  rolename            = "MyWasim"
  instanceprofilename = "MyWasemprofile"

}