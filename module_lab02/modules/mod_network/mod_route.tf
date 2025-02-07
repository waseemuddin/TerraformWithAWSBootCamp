 
resource "aws_route_table" "myapp-public-rtb" {
    vpc_id = aws_vpc.myapp-cvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myapp-igw.id
    }
    tags = {
        Name: "${var.vpc_name}-public-RT"
        enviornment: "${var.enviornment}-rtb"
    }
} 

resource "aws_internet_gateway" "myapp-igw" {
    vpc_id = aws_vpc.myapp-cvpc.id

    tags = {
        Name: "${var.vpc_name}-IGW"
    }
}

resource "aws_route_table" "myapp-private-rtb" {
    vpc_id = aws_vpc.myapp-cvpc.id
    tags = {
        Name: "${var.vpc_name}-private-RT"
        enviornment: "${var.enviornment}-rtb"
    }

}

resource "aws_route_table_association" "myapp-public-as" {
    ##Please keep in mind route table association with
    #subnets and route table id

    subnet_id = aws_subnet.myapp-public-subnet.id
    route_table_id = aws_route_table.myapp-public-rtb.id   
}

resource "aws_route_table_association" "myapp-private-as" {
    subnet_id = aws_subnet.myapp-private-subnet.id
    route_table_id = aws_route_table.myapp-private-rtb.id
}

