
resource "aws_subnet" "mycustom-subnet" {
        //vpc_id = aws_vpc.mycustom-vpc.id
        vpc_id = var.vpc_id
        cidr_block = var.mysubnet
        availability_zone = var.avail_zone
        tags = {
            Name: "${var.env_prefix}-subnet-1"
        }
}

resource "aws_default_route_table" "main-rtb" {
        //default_route_table_id = var.vpc_id.default_route_table_id
        default_route_table_id = var.default_route_table_id
        route {
            cidr_block = "0.0.0.0/0"
            gateway_id = aws_internet_gateway.mycustom-igw.id
        }
        tags = {
            Name: "${var.env_prefix}-rtb"
        }
}

resource "aws_internet_gateway" "mycustom-igw" {
        vpc_id = var.vpc_id
        tags = {
            Name: "${var.env_prefix}-igw"
        }
}
