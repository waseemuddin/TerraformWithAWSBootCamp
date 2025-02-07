
resource "aws_route_table" "public_rtb" {

    vpc_id = aws_vpc.cvpc_isb.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.isb_pub_igw.id
      
    }
      tags = {
        Name: "${var.vpc_name}-public-RT"
        environment: "${var.environment}-isb-rtb"
        }
}

resource "aws_internet_gateway" "isb_pub_igw" {
    vpc_id = aws_vpc.cvpc_isb.id
    tags = {
        Name: "${var.vpc_name}-IGW"
    }
}


resource "aws_route_table" "private_rtb" {
    vpc_id = aws_vpc.cvpc_isb.id
    tags = {
        Name: "${var.vpc_name}-private-RT"
        environment: "${var.environment}-isb-rtb"
    }        
}



resource "aws_route_table_association" "pub_isb_rtb_a" {
    count = "${length(var.public_cidr_block)}"
    subnet_id = "${element(aws_subnet.public_subnet_pisb.*.id, count.index)}"
    route_table_id = "${aws_route_table.public_rtb.id}"    
}

resource "aws_route_table_association" "pvt_isb_rtb_a" {
    count = "${length(var.private_cidr_block)}"
    subnet_id = "${element(aws_subnet.private_subnet_pisb.*.id, count.index)}"
    route_table_id = "${aws_route_table.private_rtb.id}"
}