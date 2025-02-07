output vpc_name {
    value = var.vpc_name
}

output vpc_id {
    value = aws_vpc.cvpc_isb.id
}

output environment {
    value = var.environment
}

output public_subnets_id {
    value = "${aws_subnet.public_subnet_pisb.*.id}"

}

output private_subnets_id {
    value = "${aws_subnet.private_subnet_pisb.*.id}"
    
}
output public_subnets_id_1 {
  value       = "${aws_subnet.public_subnet_pisb.0.id}"
}

