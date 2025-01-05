//subnet_cidr_block = ["192.168.1.128/25"]

//cidr_blocks = ["192.168.1.0/24", "192.168.1.0/25"] //cidr block

///cidr_blocks = [{cidr_block = "192.168.1.0/24" , name = "testing-vpc"},
          //      {cidr_block = "192.168.1.128/25", name = "testing-subnet-1"}
//

//vpc_cidr_block = "192.168.1.0/24"
//environment = "testing environment"


//vpc_cidr_block = "192.168.1.0/24"  // VPC

//subnet_cidr_block = "192.168.1.0/25" // subnet

//cidr_blocks = ["192.168.1.0/24", "192.168.1.0/25"]

cidr_blocks = [
    {cidr_block = "192.168.1.0/24", name = "tesr-vpc"},
    {cidr_block = "192.168.1.0/25", name = "test-subnet"}
    ]


environment = "CVPC environment"
