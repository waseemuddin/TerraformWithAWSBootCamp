//***** VPC TF Resource Script *****/

resource  "aws_vpc" "myapp-efs-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "${var.vpc_name}"
    }
}

//***** Subnet TF Resource Script *****/
resource "aws_subnet" "myapp-efs-public-subnet"{
    count = length(var.public_subnets)
    vpc_id = aws_vpc.myapp-efs-vpc.id
    cidr_block = element(var.public_subnets, count.index)
    availability_zone = element(var.avail_zone, count.index)
   // associate_public_ip_address = true
    tags = {
        Name: "${var.vpc_name}-public-subnet- ${count.index + 1}"
    }
}

//***** Route-Table TF Resource Script *****/
resource "aws_route_table" "default-rtb" {
    vpc_id = aws_vpc.myapp-efs-vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-efs-IGW.id
    }
    tags = {
    Name: "${var.vpc_name}-IGW"
    }
}

//***** IGW Resource Script *****/
resource "aws_internet_gateway" "myapp-efs-IGW" {
    vpc_id = aws_vpc.myapp-efs-vpc.id
    tags = {
    Name: "${var.vpc_name}-IGW"
    }
}

//***** IGW Association Script *****/
resource "aws_route_table_association" "myapp-efs-ass"{
    count = length(var.public_subnets)
    subnet_id = element(aws_subnet.myapp-efs-public-subnet.*.id, count.index)
    route_table_id = aws_route_table.default-rtb.id
}




