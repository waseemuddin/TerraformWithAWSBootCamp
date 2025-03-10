
//subnet_cidr_block = "10.0.50.0/24"
//subnet_cidr_block = ["10.0.50.0/24"]
//vpc_cidr_block    = "10.0.0.0/16"
//environment        = "development"
//cidr_blocks = ["10.0.10.0/24","10.0.20.0/24"]

cidr_blocks = [
    {cidr_block = "10.0.0.0/16", name = "dev-vpc"},
    {cidr_block = "10.0.10.0/24", name = "dev-subnet"}
]

//vpc_cidr_block = "192.168.0.0/16"

//subnet_cidr_block = "192.168.1.0/24"
environment = "development"
