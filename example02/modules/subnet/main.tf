

#Subnet Block
resource "aws_subnet" "mycustom_subnet-1"{
    //vpc_id = aws_vpc.mycustom_vpc.id
    vpc_id = var.vpc_id
    cidr_block = var.mycustom_vpc_subnet1
    availability_zone = var.avail_zone 
    tags = {
      Name: "${var.env_prefix}-subnet-1"
    }
}

/*
resource "aws_route_table" "mycustom_vpc-route_table" {
      vpc_id = aws_vpc.mycustom_vpc.id
    
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.mycustom_vpc_igw.id
    }
    tags = {
          Name: "${var.env_prefix}-rtb"
    }
}
*/

resource "aws_internet_gateway" "mycustom_vpc_igw" {
      //vpc_id = aws_vpc.mycustom_vpc.id
      vpc_id = var.vpc_id
      tags = {
          Name: "${var.env_prefix}-igw"
      }
}

//resource "aws_route_table_association" "a-rtb-subnet" {
  //    subnet_id = aws_subnet.mycustom_subnet-1.id
    //  route_table_id = aws_route_table.mycustom_vpc-route_table.id
//}

#default route table

resource "aws_default_route_table" "main-rtb" {
   // default_route_table_id = aws_vpc.mycustom_vpc.default_route_table_id
     default_route_table_id = var.default_route_table_id
    
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.mycustom_vpc_igw.id
    }
        tags = {
            Name: "${var.env_prefix}-main-rtb"
        }
}

##