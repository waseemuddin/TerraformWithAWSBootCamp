# resource "aws_internet_gateway" "mycustom-igw" {
#     vpc_id = aws_vpc.mycustom-vpc.id
#     tags = {
#         Name: "${var.env_prefix}-C-IGW"
#     }
# }

