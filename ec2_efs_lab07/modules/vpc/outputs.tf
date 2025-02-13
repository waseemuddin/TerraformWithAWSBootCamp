//***** VPC outputs *****/

output "vpc_id" {
  value = aws_vpc.myapp-efs-vpc.id
}

output "public_subnets" {
  value = "${aws_subnet.myapp-efs-public-subnet.*.id}"
}



