
//*****outputs script *****/
  output "ec2_public_ip"{
  value = "${aws_instance.myapp-efs-server.*.id}"
}

