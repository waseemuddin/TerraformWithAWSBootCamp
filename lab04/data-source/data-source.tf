
data "aws_vpc" "myvpc-2" {
  //id = var.vpc_id
  id = "vpc-0b246f2e39129cb51"

}

resource "aws_internet_gateway" "myvpc2-IGW" {
  vpc_id =  data.aws_vpc.myvpc-2.id

  tags = {
    Name = "myvpc2-IGW"
  }
}

resource "aws_subnet" "myvpc-2subnet" {
 vpc_id = data.aws_vpc.myvpc-2.id
//availability_zone = "us-west-2a"
 cidr_block = cidrsubnet(data.aws_vpc.myvpc-2.cidr_block, 4, 1)
 
}

