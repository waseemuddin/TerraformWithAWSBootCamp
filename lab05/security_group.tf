# resource "aws_security_group" "mycustom-sg" {
#     vpc_id = aws_vpc.mycustom-vpc.id

#     ingress {
#         description = "Allow all inbound traffic"
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#   }
#     ingress {
#         description = "Allow SSH"
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
#     egress {
#         description = "Allow outbound traffic"
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]

#     }
#     tags = {
#         Name = "${var.env_prefix}-C-SG"
#         Service = "Terraform"
#     }
# }