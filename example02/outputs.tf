//output "aws_ami_id" {
  //  value = data.aws_ami.latest_amazon-linux-image.id
//}

//output "ec2_public_ip" {
  //  value = aws_instance.myapp-server.public_ip
//}

output "ec2_public_ip" {
    value = module.myapp-server.instance.public_ip

}