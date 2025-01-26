## In this file we will assign the variable values

aws_region         = "us-east-1"
vpc_cidr           = "172.18.0.0/16"
vpc_name           = "C-VPC"
key_name           = "ans_key"
public_cidr_block  = ["172.18.1.0/24", "172.18.2.0/24", "172.18.3.0/24"]
private_cidr_block = ["172.18.10.0/24", "172.18.20.0/24", "172.18.30.0/24"]
avail_zone         = ["us-east-1c", "us-east-1d", "us-east-1e"]
environments       = "Production"
ingress_service    = [80, 8080, 443, 22, 3306, 1900, 1443]


