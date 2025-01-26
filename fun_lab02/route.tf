resource "aws_route_table" "public_prod_rtb" {
  vpc_id = aws_vpc.prod_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_IGW.id

  }
  tags = {
    Name: "${var.vpc_name}-public-RT"
     Owner = local.Owner
     costcenter = local.costcenter
     TeamDL = local.TeamDL
     environment : "${var.environments}"
  }
}

resource "aws_route_table" "private_prod_rtb" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
     Name: "${var.vpc_name}-private-RT"
     Owner = local.Owner
     costcenter = local.costcenter
     TeamDL = local.TeamDL
     environment : "${var.environments}"
   
  }
}



resource "aws_route_table_association" "pub_subnet_ass" {
  count = "${length(var.public_cidr_block)}"
  subnet_id      = "${element(aws_subnet.public_prod_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_prod_rtb.id}"
}


resource "aws_route_table_association" "pvt_subnet_ass" {
  count = "${length(var.private_cidr_block)}"
  subnet_id      = "${element(aws_subnet.private_prod_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.private_prod_rtb.id
}


