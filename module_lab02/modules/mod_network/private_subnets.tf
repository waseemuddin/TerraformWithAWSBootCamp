

resource "aws_subnet" "myapp-private-subnet" {
    vpc_id = aws_vpc.myapp-cvpc.id
    cidr_block = var.private_subnet_cidr_block
    availability_zone = var.avail_zone
    tags = {
        Name: "${var.vpc_name}-private-subnet" 
        enviornment: "${var.enviornment}-private-subnet"
    }
}

# resource "aws_subnet" "private-subnet-khi-sectt" {
#     vpc_id = aws_vpc.myapp-cvpc.id
#     cidr_block = var.private_subnet_cidr_block
#     availability_zone= var.avail_zone
#     tags = {
#         Name: "${var.vpc_name}-private-subnet"
#         enviornment: "${var.enviornment}"
#     }
# }