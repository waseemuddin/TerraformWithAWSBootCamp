
resource "aws_subnet" "public_prod_subnet" {
  count = "${length(var.public_cidr_block)}"
  vpc_id            = "${aws_vpc.prod_vpc.id}"
  cidr_block        = "${element(var.public_cidr_block, count.index+1)}"
  availability_zone = "${element(var.avail_zone, count.index)}"
  tags = {
     Name: "${var.vpc_name}-public-subnet-${count.index+1}"
     Owner = local.Owner
     costcenter = local.costcenter
     TeamDL = local.TeamDL
     environment : "${var.environments}"

  }

}

resource "aws_subnet" "private_prod_subnet" {
  count = "${length(var.private_cidr_block)}"
  vpc_id            = "${aws_vpc.prod_vpc.id}"
  cidr_block        = "${element(var.private_cidr_block, count.index+1)}"
  availability_zone = "${element(var.avail_zone, count.index)}"
  tags = {
     Name: "${var.vpc_name}-private-subnet-${count.index+1}"
     Owner = local.Owner
     costcenter = local.costcenter
     TeamDL = local.TeamDL
     environment : "${var.environments}"
  }

}
