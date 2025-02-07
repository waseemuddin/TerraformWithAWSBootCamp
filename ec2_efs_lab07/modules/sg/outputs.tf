//***** sg outputs *****/

output "ec2_sg_id" {
  value = aws_security_group.myapp-efs-sg.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}