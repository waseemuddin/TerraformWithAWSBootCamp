

resource "aws_vpc" "myapp-cvpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name: "${var.enviornment}-CVPC"
    }
}


# resource "aws_vpc" "vpc-sindh" {
#     cidr_block = var.vpc_cidr_block
#     tags = {
#         Name: "${var.enviornment}"

#     }    
# }