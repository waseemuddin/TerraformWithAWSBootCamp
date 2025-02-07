output  vpc_name{
    value = var.vpc_name
}

output vpc_id {
    value = aws_vpc.myapp-cvpc.id
}

output enviornment {
    value = var.enviornment
}


output public_subnets_id {
    value = aws_subnet.myapp-public-subnet.id
}

output private_subnets_id {
    value = aws_subnet.myapp-private-subnet.id
}

output public_subnets_id_1 {
  value = aws_subnet.myapp-public-subnet.id
}
