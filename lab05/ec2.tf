# resource "aws_instance" "mytest-machine" {
#     ami = var.ami_id
#     instance_type = var.instance_type
#     availability_zone = var.avail_zone
#     subnet_id = aws_subnet.mycustom-subnet.id
#     vpc_security_group_ids = [aws_security_group.mycustom-sg.id]
#     associate_public_ip_address = true
#     tags = {
#         Name: "${var.env_prefix}-mytest-machine"
#         Env = "Testing"

#     }

# }



//lifecycle {
//create_before_destroy = true
//prevent_destroy = true

//}


resource "aws_instance" "web-1" {
  #ami = "${data.aws_ami.my_ami.id}"
  ami = "ami-04b4f1a9cf54c11d0"
  availability_zone = "us-east-1a"
  instance_type = "t2.micro"
  key_name = "ans-key"
  subnet_id = "${aws_subnet.subnet1-public.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  //subnet_id                   = data.aws_subnet.Terraform_Public_Subnet1-testing.id
  //vpc_security_group_ids      = ["${data.aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  tags = {
    Name       = "Server-1"
    Env        = "Prod"
    Owner      = "sai"
    CostCenter = "ABCD"
  }
} 

