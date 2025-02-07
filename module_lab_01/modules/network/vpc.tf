


resource "aws_vpc" "cvpc_isb" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name: "${var.environment}-cvpc-isb"

    }
}


