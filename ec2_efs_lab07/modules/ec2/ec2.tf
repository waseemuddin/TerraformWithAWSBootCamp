
//*****EC2 TF Linux Code *****/
  data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
  name   = "name"
  //values = ["amzn2-ami-hvm-*-x86_64-gp2"]
   values = [var.image_name]
 }
  owners = ["amazon"]
}

//*****EC2 TF Resource Script*****/
resource "aws_instance" "myapp-efs-server" {
  count = var.vpc_name == "efs-vpc" ? 2 : 2
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id = element(var.public_subnets, count.index)
  vpc_security_group_ids = [var.ec2_sg_id]
  associate_public_ip_address = true
    user_data = <<-EOF
    #!/bin/bash
    sudo yum install -y amazon-efs-utils
    sudo mkdir -p /mnt/efs
    sudo mount -t efs ${var.efs_id}:/ /mnt/efs
    echo "${var.efs_id}:/ /mnt/efs efs defaults,_netdev 0 0" | sudo tee -a /etc/fstab
  EOF
    tags = {
    Name = var.instance_name
  }
}



//subnet_id              = var.subnet_id
  //public_subnets = module.vpc.public_subnets
  //subnet_id = var.public_subnets[0]