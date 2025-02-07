

resource "aws_subnet" "myapp-public-subnet" {
    vpc_id = aws_vpc.myapp-cvpc.id
    cidr_block = var.public_subnet_cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: "${var.vpc_name}-public-subnet" 
        enviornment: "${var.enviornment}-public-subnet"
    }
}


# resource "aws_subnet" public-subnet-khi {
#     vpc_id = aws_vpc.myapp-cvpc.id
#     cidr_block = var.public_subnet_cidr_block
#     availability_zone = var.avail_zone
#     tags = {
#         Name: "${var.vpc_name}-public-subnet"
#         enviornment: "${var.enviornment}-"
#     }
# }