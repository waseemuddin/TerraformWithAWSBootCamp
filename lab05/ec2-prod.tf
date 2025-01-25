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

