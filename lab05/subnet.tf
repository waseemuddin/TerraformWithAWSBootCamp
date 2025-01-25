# resource "aws_subnet" "mycustom-subnet" {
#     vpc_id = aws_vpc.mycustom-vpc.id
#     //cidr_block = "10.0.10.0/24"1
#     cidr_block = var.mysubnet
#     tags = {
#         Name: "${var.env_prefix} - Custom-subnet-1"
#     }
# }

