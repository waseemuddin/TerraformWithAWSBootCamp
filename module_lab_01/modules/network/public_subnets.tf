
resource "aws_subnet" "public_subnet_pisb" {
    count = "${length(var.public_cidr_block)}"
    vpc_id = aws_vpc.cvpc_isb.id
    cidr_block = "${element(var.public_cidr_block, count.index+1)}" 
    availability_zone = "${element(var.avail_zone, count.index)}"
    tags = {
        Name: "${var.vpc_name}-public-subnet-${count.index+1}"
        environment: "${var.environment}"
    }
}

