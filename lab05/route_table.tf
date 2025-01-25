# resource "aws_route_table" "mycustom-rtb" {
#     vpc_id = aws_vpc.mycustom-vpc.id
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.mycustom-igw.id
#     }
#     tags = {
#         Name: "${var.env_prefix}-C-rtb"

#     }
# }

