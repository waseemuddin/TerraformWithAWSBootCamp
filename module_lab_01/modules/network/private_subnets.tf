

resource "aws_subnet" "private_subnet_pisb" {
    count = "${length(var.private_cidr_block)}"
    vpc_id = aws_vpc.cvpc_isb.id
    cidr_block = "${element(var.private_cidr_block, count.index+1)}"
    availability_zone = "${element(var.avail_zone, count.index)}"
    tags = {
        Name: "${var.vpc_name}-private-subnet-${count.index+1}"
        environment: "${var.environment}"
    }
}